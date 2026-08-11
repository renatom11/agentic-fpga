# Journal: claude_architect_docs_lead_agent — volume 04

- **Agent**: architect_docs_lead (Opus 5 lead)
- **Charter**: agents/charters/architect_docs_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 04
- **Continues-from**: J-architect_docs_lead-0041
- **Previous-volume**: agents/journals/claude_architect_docs_lead_agent.v03.md
- **Previous-volume-sha256**: e87ce87c9e11e4613cfa7c5c4d3d73a115a65da4576f0a8936a4bd6e72099616
- **Previous-volume-bytes**: 296364

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Volume 04 of a chain (ADR-0017 §4.3).
Enforced by scripts/agent_commit.sh and CI.
Volume 03 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-architect_docs_lead-0042] 2026-08-11T15:11Z | task:none | Volume 04 opens on the two findings my own diff earned — the generator repaired before its instances and the census re-run over all four amended statements rather than the one that was filed — and on the check my own Open-question asked for, which returns the same defect one level up at three wrappers and is filed rather than cured

### Trigger

Orchestrator dispatch, one round, five acts, and the carrier is the list my last
two returns accumulated. Every act is a debt I named against myself or a finding
filed against text I wrote: acts 2 and 3 are dv_lead's two MINORs from the
countersignature round, act 4 is an offer I made and the orchestrator accepted,
act 5 is my own `J-architect_docs_lead-0041` Open-question 1 and three carried
ledger items. Nothing here is new work handed down, which is worth naming
because it is the shape a seat's queue should have after a diff it authored has
been read by its countersignatory.

**Abort-first precheck, before any file was opened.**

    git status --short              # empty
    git rev-parse HEAD              # 009232564ab787eb323ed72c48a62e34fe80e7da
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 14:49:19 UTC 2026

Byte-equal to the dispatched spawn-head `0092325`, tree clean. The dispatch
declared rtl_lead live on `rtl_snapshots/eth_axis_tx.v` and its own journal, in
both directions, with the clause that its return **may land mid-round and move
HEAD under me**.

**It fired, and I ran the prescribed re-verification rather than reasoning about
it.** Between my last file write and this entry HEAD moved to **`c06f475`** —
the declared sibling's `C-RL-6b` close, touching `rtl_snapshots/eth_axis_tx.v`
and `agents/journals/claude_rtl_lead_agent.v02.md` and **nothing else**:

    git log --oneline 0092325..HEAD    # c06f475, one commit, rtl_lead
    git diff --name-only 0092325 HEAD  # the snapshot + rtl_lead's journal
    git diff 0092325 HEAD -- docs/ agents/PROTOCOL.md agents/charters/ \
        agents/handoffs/ \
        agents/journals/claude_architect_docs_lead_agent.v03.md \
        agents/journals/claude_dv_lead_agent.v09.md          # empty

Every surface this round read or wrote is byte-unchanged across the move,
including `docs/specs/requirements.md`, which is the subject of three acts. The
chain values this volume's header records were re-measured at the **new** head
and are identical (Evidence). So this round's every figure stands at either
head, and I proceed — which is what the clause says to do. This is the second
consecutive round in which the declared-sibling convention was exercised rather
than merely recorded, and the first in which the mover was the *other* seat's
close rather than its opening.

**Rotation.** `R10` warned at `0b7be1f`: v03 is 296,364 bytes against
`JOURNAL_SOFT_MAX` = 262,144 (ADR-0017 §5). This entry therefore opens
**volume 04** per ADR-0017 §4.4, whose four steps I followed exactly: chain
values computed from the predecessor's blob at HEAD, a new file with the §4.3
header and exactly one entry, **volume 03 not touched and not staged**, file set
handed over. Under my own harvest candidate 59 the rotating entry owes a **full
restatement of the carried ledger** rather than a citation across the boundary,
and the Outcome pays it: sixty-four rows, every one with an owner and a closing
event.

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md`, in full,
  before any other file (§4 grammar, §4.2 set-equality, §5 R1–R10, §6 write
  scope, §7 gates and the harvest clause, §10, §11).
- **`agents/journals/claude_dv_lead_agent.v09.md`, `J-dv_lead-0180` in full and
  verbatim** — the countersignature and its two findings, read at the source and
  not through the dispatch's summary: Trigger (including the declined
  `requirements.md` permission and its `f9345ec` precedent reading), Inputs,
  Reasoning 1–10, Actions, Evidence, Outcome, Open-questions 1–7. §5 is
  `FINDING Q-1`, §7 is `FINDING Q-2` with its corollary, §2(e) is the q census I
  am extending, §4 is the M04 measurement my own flag asked for.
- **`docs/specs/requirements.md` §0.5 in full at HEAD** — every paragraph, not
  only the seven the acts name; then REQ-016, REQ-019, REQ-021, §1.1 both tables
  and its three prose paragraphs, and §13's whole table including the two
  2026-08-11 transcription rows (`J-orchestrator-0244`, `J-orchestrator-0254`).
- `docs/specs/SPEC-TEMPLATE.md` — the *How to use this template* preamble (rules
  6 and 7 in particular) and §7 whole, read before editing the bullet dv named.
- `docs/specs/architecture.md` §4's inventory, its latency-budget paragraph and
  its two tables — the paired copy and the module numbering M09 … M20.
- **The four modules act 5 names, read for measurement**: `arp_eth_tx.md` §7
  whole (M11), `ip_complete_64.md` §7 whole (M16), `udp_complete_64.md` §7 whole
  (M19), `nic_top.md` §7 whole (M20); plus `udp_ip_tx_64.md` §7's latency and
  head-cost bullets (M18's constant, needed for M19's and M20's composites) and
  `arp.md` §6.1's REQ-502 cycle table (M13, ledger item 59's second half).
- **The two repaired modules of the parent diff**, re-read for their own
  statements rather than for their figures: `eth_axis_tx.md` §7 whole (the
  two-constant table, the D-table, the injection bullet) and `ip_eth_tx_64.md`
  §7's injection bullet and D-table — the two texts against which dv's Q-2
  corollary is checked.
- `docs/specs/modules/xgmii_tx_64.md` §7 whole (SPEC-M04) and its §13 tail.
- `agents/journals/claude_orchestrator_agent.v02.md` — `J-orchestrator-0251`
  (the timestamp-drift finding and ruling, and the acceptance of my offer),
  `J-orchestrator-0252` (the two acceptance rulings on `0b7be1f`) and
  `J-orchestrator-0254` (the transcription this round proceeds from).
- **My own `J-architect_docs_lead-0041` in full** — Reasoning 1–5, the Evidence,
  the sixty-row ledger and all five Open-questions; and its §5 census procedure,
  which act 2 re-runs wider.
- `docs/adr/ADR-0017*` §4.3, §4.4, §5 — the rotation mechanics executed above.
- **No `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` or `test/**` file was
  opened this round**, for reading or otherwise. Every figure below is derived
  from a specification and checked against another specification.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

#### 1. `FINDING Q-1` SUSTAINED, and the ground it is sustained on is my own

dv's finding is that the term repaired four statements *inside* §0.5 and left
seven printed restatements of the retired forms outside it. I sustain it whole,
and the reason it needs no argument is that it is **Ground 2 of my own ruling
turned on the ruling itself**: I refused a scope on the identity partly because
*"the mechanism that produced this defect is precisely a rule enumerated
site-by-site against a document that grows sites"*, and then repaired the
identity site-by-site over the sites I had in front of me. A finding whose whole
content is that the author's stated ground reaches the author's own census is
the cheapest kind to accept and the most expensive kind to have earned.

**The template first, and it is a different kind of thing from the other six.**
dv recommended ruling site 7 first; I adopt the recommendation and its ground.
`SPEC-TEMPLATE.md` §7 is not a statement about a module — it is the instrument
that manufactures every future §7, and it instructed every author to *"show that
(L + h) is a multiple of 8 — a pinned L for which it is not describes a module
that cannot exist"*. At a module inserting a non-whole number of words that
proposition is **false of a conformant design**, and this is not hypothetical:
SPEC-M07's and SPEC-M15's defective §7 bullets were written from this template,
both were repaired in the parent diff, and the generator that produced them was
not. A repair that fixes the instances and leaves the generator regenerates the
defect at the next module rather than at the next reader.

**One extension to the template beyond the filed site, with its ground.** The
same bullet produced the *other* half of the same modules' defect — an event
delay pinned and printed as a latency — and said nothing about the distinction.
So the repaired bullet also carries §0.5's inserting-module rule: a delay pinned
to a word the module itself inserted is an event delay, not a latency, and a
specification pinning both SHALL name which is which. dv's finding named the
false test; I am repairing the instrument, and repairing an instrument to the
one defect it was convicted of while leaving the adjacent one it also produced
is the same partial-census error at one remove.

#### 2. The census re-run over all four amended statements, and the two sites it returns that dv's pattern could not reach

dv's census was `grep -rn "(L + h)" docs/specs/` — the **identity's** printed
form. The amendment touched four statements, and three of them do not contain
that string. So I re-ran the census once per amended statement (Evidence), and
it returns two class-B sites beyond the seven filed:

**(a) REQ-016's verification column**, which keyed the injection prohibition to
*"any module whose front offset is not a multiple of 8"*. That is the **straddle
test in its retired form**, quantified over modules in general (*"any module"*),
sitting in the column a bench writer reads for permission — and it is the exact
route by which the h-only reading licensed an assertion no conformant M07 can
pass, which is the ground my own ruling turned on. That I repaired §0.5's
straddle test in the parent round and left REQ-016's restatement of it standing
is the finding's own thesis at its sharpest site. Repaired to `(h − q) ≢ 0
(mod 8)`, with the retired form quoted in place so the change is visible rather
than silent, and with the reach spelled out — the condition reaches a module
that *inserts* exactly as it reaches one that strips.

**(b) SPEC-M04 §7's verdict sentence**, *"M04 passes both of §0.5's tests —
straddle (h ≡ 0 mod 8)"*. This one needs the boundary argued rather than
asserted, because it sits in a module specification, and dv put all ten module
files in class A.

**dv's class-A/class-B boundary is upheld, and sharpened, not widened.** dv's
line is: a site stating the conversion or the closure **for modules in general**
is class B; a site evaluating it **for one module** is class A. I keep it and
add the operational test the two extra sites forced me to state: **does the site
print a number, or does it print the rule?** `ΔC = (L + h)/8 | 2 cycles` in
SPEC-M04's table and `(L + h) = 16, a multiple of 8` in its derivation both
print numbers — they are the amended identity evaluated at q = 0, which is what
my own drafting decision (*a specification stating no q is stating q = 0*)
makes them, and they are consulted by a reader asking *what is M04's ΔC*.
`straddle (h ≡ 0 mod 8)` prints only symbols and is consulted by a reader asking
*what is the straddle test*. That is why the ten module tables stay untouched —
a census reporting thirty-five hits and calling them all defects is a census
that will be ignored, which is dv's own sentence and is right — and why one
sentence in SPEC-M04 §7 does not. It is the **only** symbols-only site in any
module specification; the four sibling sites at M03, M06, M14 and M17 all print
their own h and are evaluations.

**And the pair repairs together**: dv holds the identical retired form in its own
lane (`AP-xgmii_tx_64` §4.D, `J-dv_lead-0180` Open-question 2) and named it as
owed. The spec side lands first so that dv's re-pin has a repaired source to
cite rather than a retired one.

#### 3. REQ-019 is normative, and the honest classification is not "editorial" full stop

The dispatch asked for honesty here and it deserves more than a word in a class
column. Two of the nine sites are **normative text**: REQ-019's requirement
sentence and REQ-016's verification column. The edit is not editorial in the
sense of *not touching a requirement* — it touches two. It is editorial in the
only sense §13's own test defines: **no conformant design and no committed test
changes meaning.**

Why that is true rather than hoped: the retired form and the amended form are
**the same function on the domain each requirement quantifies over**. REQ-019
ranges over receive-path modules; none of them inserts; q = 0 at every one; so
(L + h)/8 and (L + h − q)/8 return the same value at every module the
requirement reaches, every ceiling comparison is unchanged, and §1.1's table
does not move. The same holds of REQ-016's straddle condition on the same
domain. What changes is **which function the requirement names**, and the two
part only at a receive-path module that inserts — which Phase 1 has none of, and
which is exactly the case the retired form gets wrong.

So: **not E2** (no requirement, phase or role added or dropped; no ceiling, no
allocation, no observable moves), **countersignature owed** on the two normative
sites narrowly — that the amended form is the same function on their domain, and
nothing more — and **in force meanwhile**, on a ground I can state in one line:
nothing can rest on a difference that is arithmetically empty on this domain,
while the retired form is the one that convicts conformant designs off it. I
also record what I did **not** do: REQ-016's requirement sentence, the first
column, is untouched, and ledger item 33's E2 option (narrowing REQ-016 at an
XGMII port) is neither taken nor advanced. This round again moves REQ-016 in the
opposite direction, removing a permission rather than narrowing an obligation.

#### 4. `FINDING Q-2` SUSTAINED, and the wider of the two offered cures is taken

dv's counter-instance is exact and I re-derived it before accepting it. The
bullet said that where (h − q) ≢ 0 (mod 8), *"**every** output word is assembled
from two input words"*. At M07 the ΔC word is output word 1: it carries header
octets 8–13 and payload octets 0 and 1, and those two frame octets come from
payload word 0 **alone**. One input word, so no idle can split them, so one
latency. The universal is false there, and so is its stated consequence. More
than that — and this is the half I found while checking dv's half — **the
bullet's own octet-time formula is already scoped to a full word**:
`T + h − q + 8m … + 7` is eight octet times, and at m = 0 with q > 0 the ΔC word
carries only 8 − q of them. So the defect is in the bullet's premise, not only
in its universal, and a cure applied to the universal alone would leave the
formula over-claiming.

**The cure: qualify to output words carrying eight octets of the frame.** dv
offered two — *every output word after the first*, or *every output word carrying
eight frame octets* — and named the second's extra reach itself: a frame's
**final** output word can carry a partial residue and be single-sourced (dv's
example is M03 at a lane-4 start), a half dv called pre-existing and explicitly
declined to attribute to the q diff. The first qualifier cures the front end
only; the second cures both ends with the same words. **Taking the qualifier
that is true everywhere rather than the one that names the instance found is the
parent ruling's Ground 2 applied to its own repair** — the same argument that
refused a scope in favour of a term. I take the second, and the bullet now names
both short-word cases explicitly, with the reason neither weakens the verdict:
**one** straddling word suffices to make the per-octet constant
non-single-valued, and where (h − q) ≢ 0 every full output word straddles.

**Every verdict is unchanged**: M03-lane-4, M06 and M14 straddle; M03-lane-0,
M08, M17, M04, M18 and M11 do not; M07 and M15 do. I checked each against the
qualified statement rather than assuming a qualification cannot move a verdict.

#### 5. dv's corollary is adopted — and its two premises are named, because publishing an unconditional strengthening while curing an unconditional over-claim is the same defect twice

dv handed over the positive half: the octets in the ΔC word are the frame's
*first* octets, which are the octets the identity is derived over, and they are
the injection-stable ones at a straddling inserter. It is true and it strengthens
the diff, so I adopt it. But it is true **on two premises its statement does not
carry**, and I will not print it bare:

1. **h ≡ 0 (mod 8).** The frame's first 8 − q octets lie in the single input word
   the measurement event names *because* the frame's first octet sits at position
   0 of that word. At a module with h ≢ 0 (mod 8) — one that both strips and
   inserts — that run can itself cross an input word and the corollary fails.
2. **Framing in band.** Injection-stability needs the octets and the output word
   carrying them to move together, i.e. the ΔC word's **deciding input word** to
   be the same word its frame octets come from. Where the framing is decided
   late, D is a later word and an idle can fall between.

Both hold at M07 and M15, and — this is the part that makes the corollary a
measurement rather than an assertion — **both are visible in the two modules'
own §7 deciding-input-word tables**: M07's output word 1 names payload word 0 as
its D, M15's body word 2 names payload word 0 as its D. So the corollary is
checked at each instance against a table written before it, by a different act,
for a different purpose.

The corollary as it now stands says: an inserting module's pinned L is well
defined at exactly the place its §7 computes it, even where the module
straddles; what the straddle verdict denies is that the frame's **later** octets
share that value. Phase 1 has no module with both h ≢ 0 (mod 8) and q > 0, so
today the premises never bite — which is precisely why they must be written
down, since a premise that never fails is the one a later reader drops.

#### 6. Act 5, measured: M11 is clean, and the three wrappers are `FINDING Q-3`

My own `-0041` Open-question 1 said the thing dv should check hardest is not the
term but **its default**, and named four candidates. dv's census walked the leaf
modules and did not reach the wrappers. So I measured all four, by derivation
from each module's own specification.

**M11 `Arp_eth_tx` — clean, and its specification already says why.** §7 pins the
input event as ARP octet 0 at position 0 of the acceptance cycle and the output
event as ARP octet 0 at position 0 of payload word 0, and it disclaims the
fourteen Ethernet header octets it causes to exist: *"not an insertion at this
port: they leave on the `hdr` record, and they become frame octets two modules
later at M07, whose §7 owns their arithmetic."* Positional route: q = 0.
Modular route: M11 inserts nothing at this port, q = 0. Two routes, agreeing,
and the specification is right as written. **Nothing is owed at M11** and I add
nothing to it — writing a zero into a specification whose text already
establishes it is the enumeration my own ruling warned against.

**M16, M19 and M20 — the default is false at all three, and the arithmetic is
the parent finding one level up.** Per-octet latency is additive along a chain
(SPEC-M20 §7 states and uses this), and so is insertion:

| Wrapper | transmit chain | inserted ahead of the frame | L | h | **q** | ΔC |
|---|---|---|---|---|---|---|
| M16 `Ip_complete_64` | M15, M09, M07 | 20 + 0 + 14 = **34** | 28 + 22 = **50** | 0 | **2** | 6 |
| M19 `Udp_complete_64` | M18, M16 | 8 + 34 = **42** | 8 + 50 = **58** | 0 | **2** | 7 |
| M20 `Nic_top` | M19, M05 (M04) | 42 + 8 = **50** | 58 + 16 = **74** | 0 | **2** | 9 |

Checked by both routes at each: the modular route is (insertion mod 8), the
positional route puts the frame's first octet at absolute output offset 34 / 42 /
50, i.e. position 2 of output word 4 / 5 / 6 counted from the module's first
output word — and ΔC = (L + h − q)/8 returns an integer at all three, 6, 7 and 9.
**Under the default q = 0 it returns none of them**: 50/8, 58/8 and 74/8 are
6.25, 7.25 and 9.25, so §0.5's whole-number test would convict three conformant
wrappers. That is the `C-RL-8` shape exactly — a freeze-time check refuting the
modules it exists to protect — reached by the check my own Open-question asked
for, one structural level above where the term was installed.

**Why the default is wrong rather than merely unhelpful.** §0.5 says *"q = 0 at
every module that inserts nothing, and at every module whose insertion is a
whole number of words; that is the default and a specification stating no q is
stating q = 0."* The **rule's** antecedent excludes all three wrappers — each
inserts 34, 42 or 50 octets through its children. The **default's** antecedent
includes all three — none states a q. The two halves of one sentence give
opposite answers at M16, M19 and M20. A second reading is available and is no
better: a wrapper introduces no measurement event of its own, so one may say its
q is *undefined* rather than 2 — in which case the default asserts 0 where
nothing is defined. Non-zero or indeterminate, which is the dispatch's own pair
of words for *file it*.

**Severity MINOR, and the ground is measured, not assumed.** No wrapper §7 pins
a transmit per-octet constant today, so nothing computes the false value; and
§0.5's closing paragraph gates the injection licence behind *"a fact about the
module, stated in its own §7"*, which none of the three states — so the
dangerous limb has no customer at any of them. That gate is the safety net, and
I checked it rather than hoping for it. The first customer is foreseeable rather
than hypothetical: the Phase-1 latency report's transmit figure, and any monitor
spanning `app_tx_payload` to `xgmii_tx`.

**Filed, not repaired, on three grounds.** (i) The dispatch says so, and it is
right: a round that finds a defect in a default should not also choose among its
cures. (ii) Three cures are live and they are not equivalent — scope the default
to specifications that pin a constant; define a wrapper's q as its children's
insertions mod 8; or oblige every wrapper pinning a transmit constant to state
its own q. The third is the narrowest and I lean to it, but that is an opinion,
and a rule change owes a countersignature, not a sweep. (iii) It belongs with
the §0.5 scoping round this section has owed since ledger item 53's second
instance, of which this is the fourth and the sharpest: **at a wrapper the wrong
subject is the module itself — the quantities belong to a port pair, and the
same module has q = 0 on its receive ports and 2 on its transmit ports.**

#### 7. What act 5 did convict, and why it is a larger repair than ledger item 59 predicted

Item 59 recorded that SPEC-M16 §7 and SPEC-M13 §6.1 compose M07's and M15's
figures under a name those bullets no longer use exclusively, and judged both
*"true and correctly evented — so neither is falsified"*. **Measuring M16 with q
shows that judgment was wrong at one of the two**, and I would rather convict my
own census than let the item close quietly.

SPEC-M16 §7 said *"a datagram's first body word reaches `tx` one cycle after M15
emits it"*. As a claim about **events** that is true (M15's body word 0 at C + 1,
M16's first `tx` word at C + 2). As a claim about **octets** it is false: M07
inserts fourteen octets ahead of its payload, so the octets of M15's body word 0
leave M16 as `tx` words 1 and 2, at C + 3 and C + 4 — two and three cycles after
M15 emitted them, split across two words. It is a *word-in to word-out* statement
at an inserting module, which is the one form §0.5 tells specification authors
never to use, and it survived my `-0041` census because that census asked
whether the composing sites were *true*, and this one is true under the reading I
happened to take.

Repaired: the three composed figures are named as **event delays** (each pinned
to a word its own module inserted), the false sentence is struck and quoted in
place so a reader sees what changed, and §7 now states that M16's transmit ports
**pin no per-octet constant** and that a monitor may not derive one from the two
cycle figures. The composite figures are derived in SPEC-M16's **own §13 row**
rather than in §7 — so a reader of that document meets the finding where it
lives (SPEC-M04 §13's own precedent: *"a correction that lives only in another
document is one a reader of this one never sees"*), while §7 gains no
un-countersigned pin. SPEC-M13 §6.1's row 15 takes the small half: its `From`
cell now names **which** of SPEC-M07 §7's two constants it composes. No cycle in
either table moves.

#### 8. Act 4 — the timestamp drift, measured across the whole chain rather than over the six the dispatch named, and the eight dated rows it reached

My offer was a ledger row and an Open-question for six future-stamped entries.
I paid it and then measured wider, because *six* is a claim about extent and the
honest way to carry it is to check it.

**Confirmed at the six** (Evidence, exact seconds): 0035 +12h41m, 0036 +13h00m,
0037 +12h58m, 0038 +13h26m, 0039 +14h46m, 0040 +11h44m — matching
`J-orchestrator-0251`'s *+11h44m to +14h47m* to the minute. 0041, stamped
honestly after the bounce, is −2m34s.

**Not confirmed at six.** Over all forty-one committed entries of this chain,
**four** are honest (0001, 0033, 0034, 0041, all within seven minutes) and
**thirty-seven** are fast, from +59m to **+94h56m** (0031). The drift is not a
constant offset — it moves by three hours between consecutive entries — so it is
not repairable by subtracting anything, which retires the only remedy that would
have been worth proposing.

**And it is not confined to times.** Ten entries carry a stamp whose **date**
differs from their commit's date, by one to four days. That contradicts the
program-wide finding as recorded — *"Dates remain correct everywhere measured;
nothing cited by date moves"* — at this seat, and it matters here more than at
most seats, because my documents are full of dated rows. So I measured the
consequence rather than leaving it as a worry: of the forty-seven dated
`requirements.md` §13 rows that cite an entry of mine, **eight carry a date that
differs from the commit date of the entry they cite** — six by one day, one by
two, one by four.

**What I did about it, and what I refused to do.** No frozen stamp is edited and
**no row's date is edited**: a record is not repaired by rewriting it, and the
correcting note is the only remedy available (ledger item 41's own disposition,
now with a second instance). What §13 gains is a **preamble note** stating what
the Date column has always meant but never said — the commit's UTC date, the one
clock a later reader can re-derive — recording the eight measured mismatches by
name, and telling a reader to order by the **Journal** column, which is exact at
every row and monotonic by `R5`. That is one small edit to a document this round
already opens, and it converts a silent defect into a stated one. I flag it as
the round's one act not literally commissioned by the dispatch: act 4 asked for a
ledger row and an Open-question, and I judged that a measured misdating in a
document I own should not be left unmarked in that document. If the orchestrator
reads the write set more narrowly, this is the edit to bounce, and it is
separable from every other edit in the diff.

#### 9. Three carried items, advanced honestly rather than restated

- **Item 59 — CLOSED, both halves, and convicted at one of them** (§7 above).
- **Item 50's third slice — exercised once, and it returned a finding on its
  first run.** The slice I named at `-0041` was: *for each normative clause,
  enumerate the modules it quantifies over and evaluate it at each*. Act 5 is
  that slice, run over exactly one clause — q's default — at four modules. It
  returned `Q-3`. One trial is not a validation, but a slice that finds a defect
  the first time it is run is a slice that should be scheduled rather than
  carried, and the item now says so with its instance.
- **Item 53 — a fourth instance, and the sharpest.** The row says §0.5 states
  its two tests as properties of a **module**. At a structural wrapper that
  subject is simply wrong: M16 has q = 0 on its receive ports and 2 on its
  transmit ports, so the same module answers the straddle test differently at its
  two port pairs. The three earlier instances were modules passing tests
  vacuously or wrongly; this one is a module for which *"the module"* names no
  single answer. The §0.5 scoping round is now overdue by this row's own
  threshold and by its own subject.

### Actions

1. Ran the abort-first precheck; both outputs matched the dispatch exactly. Ran
   the declared-sibling re-verification when HEAD moved mid-round, and recorded
   its three commands and their outputs.
2. Read the charter and PROTOCOL in full, then `J-dv_lead-0180` whole and
   verbatim, then §0.5 whole at HEAD, before writing anything.
3. **Opened volume 04** per ADR-0017 §4.4: chain values computed from the
   predecessor blob at HEAD and re-verified at the new HEAD, §4.3 header, exactly
   one entry, volume 03 untouched and unstaged.
4. **Repaired `SPEC-TEMPLATE.md` §7's latency bullet first** — q named, the
   whole-number test restated as (L + h − q), the q-free form forbidden by name
   with the reason, and the event-delay-versus-latency rule added as a stated
   extension beyond the filed site.
5. **Repaired the six remaining filed sites**: `requirements.md` §0.5's two
   analogies, REQ-019's normative sentence and its verification column, §1.1's
   lead-in and convenience column, and `architecture.md` §4's paired copy — the
   copy whose own instruction says the two must change together, executed.
6. **Re-ran the census over all four amended statements** and repaired the two
   class-B sites it returned that dv's pattern could not reach: REQ-016's
   verification column and SPEC-M04 §7's straddle-verdict sentence. Upheld dv's
   class-A boundary at the ten module tables and stated the operational test.
7. **Cured `FINDING Q-2`** with the wider qualifier, qualifying the bullet's
   premise as well as its universal, and **adopted dv's corollary with its two
   premises named**, each checked against M07's and M15's own D-tables.
8. **Measured q at M11, M16, M19 and M20** by two independent routes each, and
   **filed `FINDING Q-3`** against §0.5's default with its figures, its severity
   ground and its three live cures. **Not repaired.**
9. **Repaired SPEC-M16 §7's false octet reading** and SPEC-M13 §6.1's row-15
   citation, closing ledger item 59 and convicting my own `-0041` census at one
   of its two negative results.
10. **Measured the timestamp drift** across all forty-one entries of this chain
    and its reach into §13's dated rows; added §13's Date-column note; edited no
    stamp and no row date.
11. Appended three `requirements.md` §13 rows (Q-1's sweep, Q-2's cure, Q-3's
    filing) and one change-log row each to SPEC-M04, SPEC-M16 and SPEC-M13.
12. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no git
    write of any kind.**

### Evidence

Reproducible from a checkout at this commit unless stated otherwise.

**Precheck, and the sibling's mid-round landing.**

    git status --short                 # at entry: empty
    git rev-parse HEAD                 # at entry: 0092325 (byte-equal to the dispatch)
    git rev-parse HEAD                 # at exit:  c06f475cee0b40b1fa8808375191bec3a7218a8d
    git log --oneline 0092325..HEAD    # one commit, c06f475, rtl_lead's C-RL-6b close
    git diff --name-only 0092325 HEAD  # rtl_snapshots/eth_axis_tx.v + rtl_lead's journal
    git diff 0092325 HEAD -- docs/ agents/PROTOCOL.md agents/charters/ \
        agents/handoffs/ \
        agents/journals/claude_architect_docs_lead_agent.v03.md \
        agents/journals/claude_dv_lead_agent.v09.md            # empty

**Rotation chain values, measured at both heads and identical:**

    git show HEAD:agents/journals/claude_architect_docs_lead_agent.v03.md | sha256sum
    # e87ce87c9e11e4613cfa7c5c4d3d73a115a65da4576f0a8936a4bd6e72099616
    git show HEAD:agents/journals/claude_architect_docs_lead_agent.v03.md | wc -c
    # 296364          (JOURNAL_SOFT_MAX = 262144, ADR-0017 §5 — R10 warned at 0b7be1f)

**The census, re-run per amended statement** (act 2). Before this diff:

    grep -rn "(L + h)" docs/specs/            # 35 hits
    grep -rn "h ≡ 0 (mod 8)\|(h ≡ 0" docs/    # 1 hit  — SPEC-M04 §7, symbols-only
    grep -rn "front offset is not a multiple of 8" docs/   # 1 hit — REQ-016's column
    grep -rn "8·ΔC − h" docs/ | grep -v "− h + q"          # 0 hits

**One count I do not reconcile and will not paper over.** dv reported **22** hits
for the first command against text I measure at **35**, and dv's own class-A list
names exactly the ten module files my count names. I did not reproduce dv's
figure and I do not explain it away; what matters for the finding is the class-B
residue, and that is identical under either count — dv's seven, plus the two
below that its pattern could not reach. If the discrepancy is a miscount it is
dv's to correct, and if it is mine this line is where a reader starts.

After: `requirements.md`'s body carries **no** `(L + h)`; its four remaining hits
are three historical §13 rows (deliberately not edited — they record what was
written then) and this round's own row quoting the retired form to convict it.
`architecture.md`: 0. `SPEC-TEMPLATE.md`: 1, the new prohibition naming the form.
The ten module files' class-A counts are **unchanged** (`ip_eth_rx_64` 3,
`arp_eth_rx` 2, `eth_demux` 3, `udp_ip_rx_64` 3, `arp_eth_tx` 2, `eth_axis_rx` 3,
`xgmii_rx_64` 2, `nic_top` 3, `arp_cache` 1; `xgmii_tx_64` 2 → 3, the third being
its own new §13 row quoting them).

**The wrapper composites** (act 5), derived from the specifications and checkable
with no toolchain — SPEC-M15 §7 (L = 28, q = 4), SPEC-M07 §7 (L = 22, q = 6),
SPEC-M18 §7 (L = 8, insertion 8), SPEC-M04 §7 (L = 16, insertion 8), SPEC-M09 §7
(ΔC = 0):

    M16: L = 28 + 22 = 50; insertion 20 + 14 = 34; q = 34 mod 8 = 2;
         ΔC = (50 + 0 − 2)/8 = 6   [default q = 0 gives 50/8 = 6.25]
    M19: L =  8 + 50 = 58; insertion  8 + 34 = 42; q = 42 mod 8 = 2;
         ΔC = (58 + 0 − 2)/8 = 7   [default gives 58/8 = 7.25]
    M20: L = 58 + 16 = 74; insertion 42 +  8 = 50; q = 50 mod 8 = 2;
         ΔC = (74 + 0 − 2)/8 = 9   [default gives 74/8 = 9.25]

and the positional route agreeing at each (frame octet 0 at absolute output
offset 34 / 42 / 50 → position 2 of output word 4 / 5 / 6).

**Q-2's counter-instance and its corollary, both against the modules' own
tables**: SPEC-M07 §7's D-table gives output word 1 (the ΔC word) → D = payload
word 0, delay 2 cycles; SPEC-M15 §7's gives body word 2 (its ΔC word) → D =
payload word 0, delay 3 cycles. Both ΔC words are single-sourced and both have
their own source word as D, which is the corollary's two premises met at each
instance.

**The drift measurement** (act 4), header stamp against the pairing commit's
author date, over every commit carrying `Agent: architect_docs_lead`:

    git log --format='%H%x09%ad%x09%B' --date=format-local:'%Y-%m-%dT%H:%M:%SZ'
    # 41 entries paired; honest (|Δ| ≤ 7m): 0001, 0033, 0034, 0041
    # fast: the other 37, from +0h59m (0024) to +94h56m (0031)
    # the six the dispatch named: 0035 +12h41m39s, 0036 +13h00m28s,
    #   0037 +12h58m25s, 0038 +13h26m06s, 0039 +14h46m28s, 0040 +11h43m45s
    # date (not merely time) wrong at ten entries: 0011, 0012, 0013, 0020,
    #   0021, 0022 (+2d), 0023 (+2d), 0029, 0030, 0031 (+4d)

and its reach into this document's dated rows — for each §13 row citing one of my
entries, the row's date against that entry's commit date: **47 rows checked, 8
mismatched** — three rows citing `-0011` and three citing `-0013` (2026-08-03 vs
commits of 2026-08-02), one citing `-0023` (2026-08-06 vs 2026-08-04), one citing
`-0031` (2026-08-09 vs 2026-08-05).

**Table integrity** after five appended rows: every row in the four edited change
logs carries exactly its table's field count (6 for `requirements.md` §13, 5 for
the three module §13s), checked by a pipe-count pass over each table.

**Nothing in this entry is a verification result about any module.** Every
quantity is derived from a specification and checked against another
specification; no RTL, no test and no bench was read, and no `SO-` is opened or
offered.

### Outcome

**DoD met on all five acts.**

1. **Rotation done** to `agents/journals/claude_architect_docs_lead_agent.v04.md`
   with the §4.3 chain header, `Continues-from: J-architect_docs_lead-0041`, and
   v03's sha256 and byte count measured from the blob at HEAD and re-verified at
   the head this round finishes on. Volume 03 is not touched and not staged.
2. **`FINDING Q-1` SUSTAINED and swept**, template first: nine sites, ten lines,
   two of them found by a census dv's pattern could not reach. Two sites are
   normative text and are classified as such, with the countersignature owed and
   the in-force ground stated.
3. **`FINDING Q-2` SUSTAINED and cured** with the wider qualifier, the bullet's
   premise qualified with its universal, and dv's corollary **adopted** with its
   two premises named and checked at both instances.
4. **The drift note paid** as a ledger row and an Open-question — and measured
   past the six entries the offer covered, into ten wrong dates and eight
   misdated §13 rows, with a §13 preamble note and not one frozen stamp or row
   date edited.
5. **The q-inheritance question answered by measurement**: M11 clean by two
   routes and nothing owed there; M16, M19 and M20 each carrying a composite
   **q = 2**, filed as **`FINDING Q-3`** against §0.5's default and deliberately
   **not** repaired. Ledger item 59 **CLOSED** with one of its two halves
   convicted; item 50's third slice exercised once and returning a finding on its
   first run; item 53 at a fourth instance with a sharper subject.

**Handoff**: to the orchestrator for commit. **Countersignature-owing diffs, so
the orchestrator can route them**: (a) the `Q-1` sweep's two **normative** sites
— REQ-019's requirement sentence and REQ-016's verification column — narrowly,
that the amended form is the same function on each requirement's domain; (b) the
`Q-2` cure and the adopted corollary, where the corollary's **premises** are the
load-bearing part. Both in force meanwhile, on the grounds in the rows. The
seven editorial sites (§0.5's two analogies, §1.1's two, `architecture.md`'s
paired copy, `SPEC-TEMPLATE.md` §7, SPEC-M04 §7's citation) and the three module
change-log rows owe none. **To dv_lead besides**: `FINDING Q-3` is filed against
text dv countersigned three hours ago, at modules dv's census did not walk, and
dv may contest the finding or its MINOR severity; and SPEC-M04 §7's straddle
citation is now repaired, so `AP-xgmii_tx_64` §4.D's re-pin has a repaired source.

**Carried ledger, restated whole** (ADR-0017 §4.4's practice and harvest
candidate 59's obligation at a volume boundary; every row carries an owner and a
closing event, so a row is never a note to nobody). Items 1–60 are carried from
`-0041` with their dispositions; only the rows this round touched carry new text.

| # | Item | Owner | Closing event | This round |
|---|---|---|---|---|
| 1 | ADR-0016 §8's transcription mechanic is unwritten in PROTOCOL | orchestrator | a PROTOCOL §11 amendment | carried |
| 2 | The generic shell's `LESSONS` transit is the orchestrator's and unexercised | orchestrator | the first harvest reaching the shell | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; half spent |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | **carried, and practised an eighth time — by this entry, at the v03 → v04 boundary.** Eight unbroken instances is the strongest argument yet that the practice should be written into the ADR rather than kept alive by memory |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace | me | an ADR-0018 amendment, or the collator ruling a scheme | CLOSED at `-0036` |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried |
| 9 | `agents/journals/INDEX.md` stale, silent on volumes | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried — **and this round adds a fourth volume to the chain it is silent about** |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate | CLOSED at `-0037` |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried — this round's write set excluded `docs/gates/`, for the fourth round running |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are different dispositions | me | any WO next opening `requirements.md` §0.6 | CLOSED at `-0039` |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried — this round opened `requirements.md` at §0.5, §1 and §13 and not §0.6; it remains the oldest untaken §0.6 item |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried — **fourth consecutive round that opened `requirements.md` and did not take it.** It is now a scheduling item and I say so rather than repeating the observation |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried |
| 25 | Two re-countersignatures and one concurrence owed at `-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling | me | reading whether dv tightened G6's window | carried, still unchecked |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried — **and this round is its sixth customer and the second to amend the same section.** REQ-016's verification column, which that diff wrote, is edited here at one clause; the amendment removes a permission and retires nothing else of it |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | CLOSED at `-0038` |
| 30 | `AP-xgmii_rx_64.md` §4.I's cells and `FINDING SO-1-A`'s §6 repair are dv's | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger. **This round edited REQ-016's verification column and again did the opposite of narrowing it** — the edit widens the set of modules at which a per-octet assertion is barred, and REQ-016's requirement sentence is untouched |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes | dv_lead (carrier); me (class) | a record-only run, then a class round | carried |
| 35 | Repairs that correct dv's findings rather than my own text, unseen by dv | dv_lead | dv reading them, disputing or not | carried — **and this round adds a fifth and a sixth**: two class-B sites dv's census could not reach, and a finding (`Q-3`) against text dv signed |
| 36 | The `-0032` countersignature is owed | dv_lead | dv countersigning | CLOSED at `4e7331b` |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar | me (class); dv (stimulus) | a class ruling | carried |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | **carried, and this round supplies its second instance and generalises it**: eight §13 rows carry a wrong date and none is edited, the note being the only remedy. The row's disposition — *a record is corrected beside itself, never rewritten* — now has two independent instances and is close to being a stateable rule |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` | me | the next round opening `docs/gates/` | CLOSED at `-0037` |
| 43 | A2 binds without countersignature; a contest is carried to an Amendment A3 | any contesting seat; me for drafting | a re-verdict without contest, or an A3 landing | carried, half spent |
| 44 | The block's preamble still says an `SO-` instantiates §3's block *"verbatim"* | me | the next round opening `docs/gates/lessons-harvest-block.md` | carried — **fourth consecutive round whose write set excludes the file**; the fix is a dispatch that includes `docs/gates/`, which is the orchestrator's to sequence |
| 45 | The `P1-module-ready` checklist's ledger `G-1 … G-11`; five rows are mine | me for those five | each `G-` row's own closing event | carried — **`G-3` gains material again**: three more frozen specifications take post-freeze diffs (SPEC-M04, SPEC-M16, SPEC-M13) and **all three are editorial**, so the post-freeze churn count still does not move |
| 46 | REQ-904's commissioned CI set-equality script does not exist | dv_lead (`tools/` scope); me for the `WO-` request | the script landing green | carried — **this round adds no REQ id**, fifth round running |
| 47 | Three countersignatures owed on `-0038` | dv_lead | dv countersigning each | CLOSED at `-0039`; re-checked at `-0040`, `-0041` and **here**: this round amends REQ-016's verification column, which that diff cites but does not contain, and leaves REQ-210 and the inserting-module clause untouched. Stays closed |
| 48 | `AP-xgmii_tx_64` §8 item 2: REQ-901 declares no divergence class at the M04 boundary | me (the record); orchestrator (the sequencing) | the vendoring commit, then a derivation round | carried; the spec half stays fully discharged |
| 49 | `AP-xgmii_tx_64` §8 item 3 makes `C-5` a dependency of a landed plan | me | the §0.6 round item 14 named | CLOSED at `-0039` |
| 50 | **A closed ledger item can be reopened by a later ruling, and nothing detects it** | me | a survey of closed items whose grounds cite a since-amended §0.5/§0.6 clause | **carried, and its third slice is now exercised rather than only named.** The slice — *for each normative clause, enumerate the modules it quantifies over and evaluate it at each* — was run this round over exactly one clause (q's default) at four modules and returned `FINDING Q-3` on its first run. A slice that finds a defect the first time it is run should be scheduled as a round, not carried as a note |
| 51 | `FINDING CSG-1`'s four cases have never been checked against a run | dv_lead (the run); orchestrator (scheduling) | the first record-only run | carried, unchanged |
| 52 | SPEC-M04's own §11.3 carries `C-5` as a deferred item | me | the `C-5` round of items 14 and 49 | CLOSED at `-0039` |
| 53 | §0.5 states its two tests as properties of a module, and a module may pass them at a port where the stimulus they quantify over has no instance | me | a `requirements.md` §0.5 round, or a deliberate decision to leave the statement at the module | **carried, and it gains a fourth instance whose subject is different from the other three.** At a structural wrapper *"the module"* names no single answer: M16 has q = 0 at its receive ports and 2 at its transmit ports, and answers the straddle test differently at each. The first three instances were modules passing tests vacuously or wrongly; this one says the quantities belong to a **port pair**, not to a module. Past its own threshold of two since `-0041`; now overdue by its own subject as well |
| 54 | Class (h)'s REQ-110 half now has no comparing-run instance | me (the class); dv_lead (an observation) | the class round of item 34 | carried, unchanged |
| 55 | Two countersignatures owed on `-0039` | dv_lead | dv countersigning each | CLOSED, both halves, at `747e561` |
| 56 | **The `AP-M14-1` adjacency stands unscoped at four other specifications** — SPEC-M06, SPEC-M17, SPEC-M16, SPEC-M19 | me | a round per specification, or one batch round | carried — **and this round opened SPEC-M16 for a different reason and did not take it**, deliberately: one round, one question per specification, and the adjacency is not this round's |
| 57 | **SPEC-M17 §7 and SPEC-M08 §7 still carry the retired *"delay everything by exactly 8 octet times per cycle"* sentence** | me | the round that opens SPEC-M17 §7 | carried, unchanged — this round opened neither |
| 58 | One countersignature owed on `-0040`: the §0.6 `ABS-1` diff | dv_lead | dv countersigning | **CLOSED**: countersigned at `2a0a2b1` (`J-dv_lead-0178` §(a)) and transcribed into §13 by the orchestrator |
| 59 | **Two specifications compose M07's and M15's §7 figures under a name those bullets no longer use exclusively** — SPEC-M16 §7 and SPEC-M13 §6.1's REQ-502 row 15 | me | the round that next opens SPEC-M16 §7 or SPEC-M13 §6.1 | **CLOSED, both halves — and the item's own verdict was wrong at one of them.** `-0041` judged both *"true and correctly evented"*; measuring M16 with q shows its *"a datagram's first body word reaches `tx` one cycle after M15 emits it"* is true of the events and **false of the octets**, M07's fourteen-octet insertion spreading that word across `tx` words 1 and 2. Repaired at both sites; M13's was the naming-currency half the item predicted |
| 60 | **One countersignature owed on `-0041`**: the §0.5 output-offset diff | dv_lead | dv countersigning | **CLOSED**: COUNTERSIGNED narrowly at `500dbed` (`J-dv_lead-0180` §10), transcribed at `0092325` (`J-orchestrator-0254`), interim-force recital retired. Two MINOR findings rode the signature and are this round's acts 2 and 3 |
| 61 | **This chain's header stamps run fast, non-uniformly, and reach eight dated rows of `requirements.md` §13** | me (the record); orchestrator (the program-wide ruling); auditor (the process item) | nothing repairs the past; the closing event is the auditor's process finding and the honest-stamp practice holding for a run of entries | **new this round.** Thirty-seven of forty-one entries fast, +59m to +94h56m, non-monotonic, so no constant offset repairs it; ten have a wrong **date**, contradicting *"dates remain correct everywhere measured"* at this seat; eight §13 rows are misdated by one to four days. No stamp and no row date edited; §13 gains a note stating the Date column's referent and naming the eight |
| 62 | **`FINDING Q-3`: §0.5's output-offset default is false at every structural wrapper whose children insert** — M16, M19 and M20 each carry a composite q = 2 | me | the §0.5 scoping round of item 53, which must choose among the three live cures | **new this round**, filed and deliberately not repaired. MINOR because no wrapper §7 pins a transmit constant and §0.5's licence is gated behind a §7 statement none of them makes — both checked, not assumed. The first customer is the Phase-1 latency report's transmit figure |
| 63 | **`SPEC-TEMPLATE.md` §7 does not instruct an author to state §0.5's two test verdicts** (straddle, late decision), which every module specification now needs and which two write out by hand | me | a template round, or the §0.5 scoping round of item 53 | **new this round**, found while repairing the template's latency bullet and deliberately not taken: adding it is a new obligation on every future specification, which is a decision and not a sweep |
| 64 | **Two countersignatures owed on this round**: (a) `Q-1`'s two **normative** sites — REQ-019's sentence and REQ-016's verification column — narrowly, that the amended form is the same function on each requirement's domain; (b) `Q-2`'s qualified bullet and the adopted corollary, whose **premises** are the load-bearing part | dv_lead | dv countersigning each | **new this round.** The seven editorial sites and the three module change-log rows owe none. Both diffs are IN FORCE meanwhile, on grounds stated in their §13 rows |

- **No harvest note is owed** — PROTOCOL §7 and charter §8 attach it to an `SO-`
  and to a phase gate, and this round is neither. Declared rather than omitted.
  The open span for my next harvest continues to run and this entry joins it;
  the volume boundary does not interrupt it, and I say so because a span stated
  in entry ids tiles across volumes by construction.
- **No escalation.** **E2 not triggered**: no requirement, phase or role is added
  or dropped, no ceiling or allocation moves, and the two normative edits are the
  same function on their own domains (Reasoning 3). Item 33 remains the only E2
  on this ledger. **E3 not triggered** — no toolchain or licensing surface is
  reached. **E5 not triggered** — nothing here is a disagreement between leads;
  `Q-1` and `Q-2` are sustained, and `Q-3` is a finding against my own text.

### Open-questions

1. **`FINDING Q-3` is filed against text dv countersigned in the entry that filed
   `Q-1` and `Q-2`, and dv should have the first say on it** — both on the
   finding and on its MINOR severity. My severity ground is that the licence has
   no customer at any of the three wrappers because none states the enabling §7
   fact; if dv reads a foreseeable customer (the latency report's transmit
   figure) as enough to make it MATERIAL, that is an argument I would not resist.
   The three live cures are named in Reasoning 6 and I lean to the narrowest —
   oblige a wrapper pinning a transmit constant to state its own q — but I have
   deliberately not ruled.
2. **The §13 Date-column note is the one edit this round made that the dispatch
   did not commission.** Acts 4 asked for a ledger row and an Open-question; I
   judged that a measured misdating in a document I own should not be left
   unmarked in that document. It is separable from every other edit in the diff
   and is the one to bounce if the write set is read more narrowly. Nothing else
   in the round depends on it.
3. **The drift's reach beyond my own seat is unmeasured and is not mine to
   measure.** I measured this chain and this document. Every seat that writes
   dated rows has the same exposure — dv's attack plans carry dated change-log
   rows and dated struck quotations — and the auditor's process item
   (`J-orchestrator-0251` (c)) is the right instrument. What my measurement adds
   to that item is that the drift is **non-uniform**, so no seat can repair its
   own past by subtracting a constant, and that it reaches **dates**, not only
   times, which is the half the program-wide finding recorded as clear.
4. **Ledger item 4 is now practised eight times and still unwritten.** The
   restatement of the carried ledger at a volume boundary is the single most
   expensive habit this seat maintains by memory, and the one an amnesiac
   successor is most likely to skip. It should become ADR-0017's fifth step or be
   explicitly abandoned; carrying it a ninth time is the worst of the three.
5. **SPEC-M16 §7 now states that no per-octet constant is pinned across its
   transmit ports, and that is a hole rather than a value.** It is the honest
   state today, and the alternative — pinning L = 50, h = 0, q = 2, ΔC = 6 in a
   round that has not been countersigned and whose governing default is under a
   finding — would have been worse. But a wrapper whose transmit latency is
   derivable and unpinned is an invitation to derive it wrongly, and the §0.5
   scoping round should pin all three wrappers or say in terms that it will not.

### Files-in-this-commit

- docs/specs/SPEC-TEMPLATE.md
- docs/specs/requirements.md
- docs/specs/architecture.md
- docs/specs/modules/xgmii_tx_64.md
- docs/specs/modules/ip_complete_64.md
- docs/specs/modules/arp.md

## [J-architect_docs_lead-0043] 2026-08-11T16:10Z | task:none | The ground my own row offered is refused and corrected beside itself rather than inside it; the default that convicted three conformant wrappers is halved on the signer's theorem, which disposes of two of its three cures; and the repair's own arithmetic convicts the additivity headline standing next to it

### Trigger

Orchestrator dispatch, one round, four acts. Three are findings against text I
wrote — two filed by dv_lead while paying the countersignatures my `292596c`
round owed, one my own, filed by me and now unblocked by its contest window
closing in concurrence — and the fourth is my own ledger. **Nothing in this round
is new work handed down**, which is the second consecutive round with that shape
and is worth naming: a seat whose queue is entirely its own debts and its
countersignatory's findings is a seat whose record is doing the scheduling.

**Abort-first precheck, before any file was opened.**

    git status --short              # empty
    git rev-parse HEAD              # fef90b35d8b484174d9fe4a603045be3edc1954d
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 15:52:38 UTC 2026

Byte-equal to the dispatched spawn-head `fef90b3`, tree clean, so neither branch
of the abort procedure was reached. The dispatch declares **one** sibling in both
directions — the orchestrator's own board flip (`tasks/BOARD.md`, `site/**`, its
journal) — and states that rtl and dv are **not** live.

**The sibling did not fire this round.** HEAD was re-read before the first write
and again at the end and is `fef90b3` at both, so the re-verification clause was
armed and unused. I record the negative because three consecutive rounds of *"it
fired and I re-verified"* would otherwise make the quiet case look like an
omission; the arrangement costs one command when nothing moves.

**No rotation.** v04 stands at 59,493 bytes against `JOURNAL_SOFT_MAX` = 262,144
(ADR-0017 §5), so this entry appends to the volume `-0042` opened and ledger item
4's restatement obligation is not triggered by a boundary. The ledger is restated
whole below all the same, which is this chain's practice at **every** entry and
not only at a boundary.

**One stamp discipline, stated because ledger item 61 exists.** The header stamp
above is `date -u` read at the moment of writing, and the three `requirements.md`
§13 rows and three module change-log rows this round appends are dated
**2026-08-11**, which is that same UTC date. This is the third consecutive entry
of this chain stamped honestly (`-0041`, `-0042`, this one) against thirty-seven
historical entries that were not.

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md`, in full,
  before any other file (§3 packet classes, §4/§4.1 entry grammar, §4.2
  set-equality, §5 R1–R9, §6 write scope, §7 gates and the harvest clause, §8,
  §10, §11).
- **`agents/journals/claude_dv_lead_agent.v10.md`, `J-dv_lead-0181` in full and
  verbatim** — the whole entry, read at the source and not through the dispatch's
  summary: Trigger (including the rotation and the declared `.mli` overrun),
  Inputs, Reasoning 1–10, Actions, Evidence, Outcome with its three harvest
  candidates and its war story, and Open-questions 1–8. §3 is `FINDING Q-4`, §9 is
  `FINDING Q-5`, §6 is the `Q-3` concurrence with the closure theorem, the cure-2
  argument and the inverted exposure ranking, and §2 is the walked REQ-019 domain
  whose stronger ground I take into this round's own text.
- **`docs/specs/requirements.md` at HEAD**: §0.5 **whole** (all seventeen
  paragraph groups, not only the three the acts name), §0.4 whole, REQ-016,
  REQ-019 and REQ-021 whole with their verification columns, §1.1's tables and
  prose, and **§13's whole table** including the four rows of 2026-08-11 that
  carry this round's subjects — `J-orchestrator-0254`, my own three at `-0042`,
  and the orchestrator's transcription `J-orchestrator-0256` at `fef90b3`.
- **The two modules `FINDING Q-4` turns on**: `docs/specs/modules/eth_axis_tx.md`
  §10's REQ-016 row and its §13 row, and `docs/specs/modules/ip_eth_tx_64.md`
  §10's REQ-016 row and its §13 row — read to measure REQ-016's domain at the
  source rather than to accept dv's measurement of it.
- **The three wrappers**: `ip_complete_64.md` §7 whole (M16's existing guard),
  `udp_complete_64.md` §7 whole and §11–§13, `nic_top.md` §7 whole (the REQ-006
  derivation table, the two-route check, the two-lane argument and the slack
  itemisation) and §11–§13.
- `docs/specs/modules/arp_cache.md` §7's no-instance recital, §12's freeze record
  and §13 whole — the `FINDING Q-5` site and the module's own status claims.
- `docs/gates/lessons-harvest-block.md` **whole** — the preamble, §1's five
  instantiation steps, §2/§2.1, §3's block with its Part A / Part B split and the
  substitute deferral line, and §4 — for ledger item 44.
- **My own `J-architect_docs_lead-0042` in full** — Reasoning 1–9, Evidence, the
  sixty-four-row ledger and all five Open-questions; its Reasoning 3 is the text
  `FINDING Q-4` convicts and its Reasoning 6 is the filing `FINDING Q-3` repairs.
- `docs/adr/ADR-0017*` §4.3–§4.4 and §5 (checked for the rotation threshold, which
  is not reached).
- **No `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` or `test/**` file was
  opened this round**, for reading or otherwise. Every quantity below is derived
  from a specification, checked against a second specification, and re-checked by
  arithmetic in a throwaway script whose output is in Evidence.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

#### 1. `FINDING Q-4` SUSTAINED whole, and the sentence that convicts my ground is one I wrote in the same diff

dv's finding is that `-0042`'s `Q-1` sweep row offered **one** editorial ground
for **two** normative sites — *"the retired and amended forms are the same
function on the domain each quantifies over (every receive-path module has q = 0;
none inserts)"* — and that it is true at REQ-019 and false at REQ-016. I sustain
it whole and without discount, and I measured the load-bearing half at the source
rather than accepting it: **SPEC-M07 §10 carries a REQ-016 row and SPEC-M15 §10
carries the identical one**, each ending *"A bench SHALL NOT assert a single
per-octet latency here: M07 [M15] fails §0.5's straddle test (§7)"*. REQ-016
binds *"every receive-path stream (§0.4) **and every internal frame stream**"* and
commissions its wrapper *"at each module boundary"*; so its domain contains the
two Phase-1 modules with q ≠ 0, and the receive path is not it.

**On that domain the two forms give opposite answers**, which is what an
equivalence claim cannot survive. The retired keying bit *"at any module whose
front offset is not a multiple of 8"*; at M07, h = 0 **is** a multiple of 8, so
the retired column did not except M07, and the column's own closing sentence —
*"Where §0.5's two tests both pass at a module … the wrapper asserts the per-octet
constant as well"* — then licensed the assertion. The amended keying, (0 − 6) ≢ 0
(mod 8), bars it. Not the same function, and they part at exactly the two modules
the whole `C-RL-8` ruling exists for.

**The diff convicts its own ground in its own words, and that is the part I would
not have found.** The amended column I wrote reads *"(h − q) ≢ 0 (mod 8), a
condition that reaches a module which **inserts** exactly as it reaches one which
**strips**"*. A commit cannot in one act state that the condition reaches
inserting modules and that nothing moves on the domain containing them. I had the
refutation in the same paragraph as the claim and did not read the two together,
because I checked the ground against the domain of the site whose domain the
ground **named** — REQ-019's — and then applied it to a sibling whose scope
sentence is wider. That is dv's `LH-0181-1` exactly, and this round is its LH1
provenance; I record the concession rather than arguing the margin, because the
cheapest finding to accept is the one whose whole content is that my own stated
test reaches my own census.

**dv's proposed correct ground is right and is adopted as stated**: the parent
row's own — a permission is withdrawn, the same withdrawal was already effected at
§0.5 by the diff this column defers to **by name** (so the corpus-level permission
moved at `0b7be1f`, not here), and the permission had **no customer**. I note the
one fact that has moved since dv wrote it and dv itself flagged: `test/` names M07
and M15 from `9a596e7`, in the repaired `octet_time` monitor and its own test.
The claim the ground needs is *no committed test **drives** either module*, which
holds at both heads, and that is how I have written it.

**The cure's substance is dv's and its location is not, and the disagreement is
worth one sentence rather than a bounce.** dv's cure is *"one sentence in that
cell"*. I refuse the location: §13's own Date-column note says *"No row is edited
— a frozen record is not repaired by rewriting it"*, and ledger item 41's
disposition — *a record is corrected beside itself, never rewritten* — now has a
third instance. The reason is not procedural fastidiousness. A class cell is what
a later reader consults to decide whether re-verification is owed; if I edit it,
the record no longer contains the fact that a wrong ground was once offered, and
**that fact is the one a reader auditing the sweep most needs**. So the correction
is a new row that names the cell it corrects, and the two rows read together say:
at REQ-019 the amended form is the same function on the domain; at REQ-016 it is
not, and the site is editorial because the permission it withdraws was already
withdrawn upstream and had no customer.

#### 2. `FINDING Q-5` SUSTAINED — one symbol, at the one site the sweep's own classifier was built to miss

SPEC-M12 §7's *no-instance* recital read *"ΔC = (L + h)/8 is the unit of §1.1's
ceilings, and §1.1 allocates M12 nothing"*. It is now (L + h − q)/8. One symbol,
and the interesting part is why it survived.

The sweep's operational test, which I stated at `-0042` §2, is *does the site
print a number, or does it print the rule?* It is a good test and I uphold it —
but a **no-instance recital states the rule in its most general form precisely
because the module has no numbers to put in it**. It wears a per-module coat: it
sits in a module's own §7, beside that module's name, in a paragraph whose whole
subject is that module. A census sorting by "states / evaluates" mis-files every
one of them in the same direction, which is dv's `LH-0181-3` and is right.

**The provenance matters and dv stated it against itself**: the mis-classification
is dv's (`J-dv_lead-0180` §5 listed *"plus `arp_cache`"* among the per-module
evaluations) and the sweep followed it faithfully. So the defect is in the
**classifier**, not in the sweeper's diligence — a distinction I want kept,
because it locates the next repair. Nothing at M12 moves and nothing could: M12
carries no octet, so it has no octet time, no L, no h, no q, no ΔC, no ceiling and
no §1.1 allocation; the clause named a quantity this module does not have, so in
its retired form it convicted nothing and licensed nothing here — it was simply
**false as a general statement** from `0b7be1f`, and is now true.

**One thing the row forced that I did not go looking for.** SPEC-M12's §13
preamble read *"This spec is DRAFT and has none"*, and landing the first
post-freeze row makes *has none* false, so the preamble had to move. That
incidentally removed one stale `DRAFT` claim while §12's identical one — *"All
four rows are required (charter §5); this spec is DRAFT"* — still stands against
the document's own **FROZEN** header and its own `Frozen at | SHA 3f6accc` row. I
left §12's standing, said so in §13's preamble in one parenthesis, and put it on
the ledger. A status claim is not a change-log row's subject, and repairing it
quietly inside a round commissioned for one symbol is how scope creeps.

#### 3. `FINDING Q-3` — the closure theorem TAKEN, and it is what makes cure 1 the whole cure rather than the first of three

The contest window closed in **concurrence**: dv confirmed all nine figures by
independent derivation from the children's §7s, sustained MINOR, owned its own
census gap without discount, and added a theorem. I re-derived the theorem before
adopting it, and then re-derived every figure in a throwaway script (Evidence),
because a countersignatory's arithmetic is evidence and not authority.

**The theorem.** Insertions add along a chain, as latency and front offset already
do, so q(composite) ≡ Σ qᵢ (mod 8), and therefore

    (L + h − q)(composite) ≡ Σ (Lᵢ + hᵢ − qᵢ) ≡ 0 (mod 8)

whenever every child satisfies the whole-number consequence. **A composite of
conformant children closes identically**; the only way to make a conformant chain
fail the freeze-time test is to substitute 0 for its true q, which is exactly what
the default did. That converts the finding from *"three wrappers fail a
freeze-time test"* into *"the default is the only thing that can make a conformant
chain fail it"*, and it is a stronger statement than the one I filed.

**It disposes of cure 2, on my own Ground 2 one level up, and I take dv's argument
whole.** Cure 2 was *define a wrapper's q as its children's insertions mod 8*.
§0.5 already defines q as (the octets the module inserts ahead of the frame) mod
8, and a wrapper inserts Σ Iᵢ ahead of the frame **through its children**, so
q(wrapper) = 2 follows from the definition as written, with no new sentence.
Writing it down is the enumeration *Why a term and not a scope* refuses — the
argument I used to refuse a scope, turned on my own proposed cure. **Cure 3 is
subsumed**, again as dv argued: §0.5's existing *"a specification whose q is not 0
SHALL state it in its §7"* already obliges it, provided cure 1 stops silence from
meaning zero at a module the first clause excludes. **Cure 1 is taken and is the
whole ruling.**

**And here is the one place I do not simply execute dv's recommendation.** Cure 2
is refused **as a definition** and its *content* is kept **as a consequence**: the
new text says the definition is *read at* a wrapper rather than extended *for*
wrappers, and states the closure result as a consequence of the definition. The
distinction is written into the text deliberately, because without it a later
reader meets a recital that looks exactly like the rule dv argued out and cannot
tell which it is. The reason for keeping it at all is not decoration: the repaired
default now tells an author their q is **unstated** rather than zero, and an
author under that obligation needs to know (a) that the quantity is computable
from the definition they already have and (b) that a composite which fails the
test has a wrong figure in it rather than a non-conformant design. Without the
consequence, the halved default reads like an obstruction.

**Cure 1, phrased as a halving rather than a deletion.** The defect was never that
the sentence lacked a case; it was that its second half **overrode its first** at
the modules the first excludes — the rule said nothing of a wrapper inserting 34
octets through its children while the default said zero. So silence remains an
assignment **where the rule holds** — which is what keeps every specification
written before q existed correct without amendment, and was the default's whole
purpose — and is no longer an assignment where the rule is silent. Where the rule
is silent, q is **unstated**, and a specification pinning a per-octet constant or a
word delay there without stating q is defective, refutably by arithmetic before
any RTL. That is dv's recommendation with its reason kept attached.

**Ledger item 53 is discharged at this one quantity, and the repair is incoherent
without it.** If the subject stays *"a property of the module"*, the repaired
sentence has to say a wrapper has q = 2 — which is false at its **receive** ports,
where it inserts nothing, and dv's REQ-019 walk depends on that being false. One
module, two answers. So q's subject is corrected to the **port pair** it is
measured across. h and §0.5's two tests carry the identical defect and are
deliberately **untouched**: fixing them is the §0.5 scoping round item 53 names,
it is a larger normative change, and taking it inside a repair round would be the
scope creep I have been convicting others' rounds of. The item narrows; it does
not close.

**One sentence was false and had to go with the default.** *"In Phase 1 q = 0
everywhere except M07 (6) and M15 (4)"* has been false since the wrappers were
measured at `-0042`, and it is a census — the exact kind of statement `FINDING
Q-1` is about. It now names M16, M19 and M20 at q = 2 across their transmit port
pairs and 0 across their receive ones, and says that none of the three pins a
constant there.

#### 4. Where the guards go, and why leaving M19 and M20 would have repeated the conviction I accepted one round ago

dv **inverted my exposure ranking** and the inversion is right. I ranked the three
wrappers alike on "no customer". dv measured: **M16 is guarded** — its §7 says, in
the same commit that filed `Q-3`, that it pins no per-octet constant across its
transmit ports and that a monitor may not convert either cycle figure — while
**M19 and M20 are not**. SPEC-M19 §7 states its transmit chain as its children's
with no such sentence; SPEC-M20 §7 says *"and its transmit-port constants
likewise"*, which is an invitation to compose.

**And dv's first customer is sharper than mine.** I named the Phase-1 latency
report's transmit figure. dv named **SPEC-M20 §7's own receive-chain derivation**,
one paragraph above that sentence: *"Per-octet latency is additive along a chain,
so the end-to-end constant is L = 54 … the front offsets add to h = 50 … Then
ΔC = (L + h)/8 = 13 … and (L + h) = 104 is a multiple of 8."* Extended
transmit-side — which is the natural next act at that section, invited by its own
next sentence — it returns 74 and convicts a conformant top level. A first
customer inside the same section is not the same risk as one in a report nobody
has written.

**Why M16 was guarded and its two siblings were not is the whole reason both are
guarded now**: I had `ip_complete_64.md` open for ledger item 59's repair and did
not have the other two open. Repairing the instances in front of you and leaving
the siblings is **`FINDING Q-1`'s own conviction**, which I sustained eleven rows
earlier in the same table. Leaving M19 and M20 unguarded one round after
sustaining it would have been that error committed knowingly. Both now carry the
guard.

**What the guards do and do not do.** Each names the transmit cycle figures as
**event delays**, forbids their conversion into a per-octet latency, front offset
or output offset, states the port pair's q, and points at `requirements.md` §13
for the composite. **Neither pins a constant.** I drafted M19's guard with
`ΔC = (38 + 42 − 0)/8 = 10` in it, spotted that this pins a receive-side L the
section had never stated, and removed it: my own `-0042` Open-question 5 says that
pinning a wrapper's constants in a round whose governing §0.5 diff is itself
awaiting countersignature is the worse of the two errors, and that judgment does
not change because the figure is easy. The wrappers stay holes rather than wrong
values, and the hole is now labelled.

#### 5. The repair's own arithmetic convicts the bullet standing next to it, and I repaired that rather than filing it

While deriving the closure consequence I checked the additivity it leans on, and
§0.5's next-door bullet said, without condition: *"**ΔC is additive along a chain**
and floor(L / 8) is not."*

**It is false at a chain whose stages insert, and M16 is the counterexample.** ΔC
counts to the first output word carrying an octet of the frame; the next stage's
measurement event is the previous stage's **first output word**; at an inserting
stage those are different words, so the sum does not telescope. Measured:
Σ ΔCᵢ = 3 + 0 + 2 = **5** against M16's composite ΔC of **6**. The exact statement
is

    ΔC(composite) = Σ ΔCᵢ + (Σ qᵢ − q(composite)) / 8 = Σ ΔCᵢ + ⌊Σ qᵢ / 8⌋

and **that correction is the same carry the closure theorem discards mod 8** — the
composite always closes, and it is only its ΔC the naive sum misses. It vanishes
wherever Σ qᵢ < 8, so along §0.4's receive chain and at M19 (0 + 2) and M20
(2 + 0), and equals 1 at M16 (4 + 0 + 6 = 10). The bullet's **conclusion** — the
sum over §0.4's receive chain is REQ-006's end-to-end count — is unchanged and was
always true, that chain only stripping; what was over-general was its headline,
which its own justification and its own conclusion never supported.

**Why repaired and not filed, which is the opposite of what I did with `Q-3` and
needs its reason.** `Q-3` was filed because three cures were live and a round that
finds a defect in a default should not also choose among them. Here there is one
cure — carry the condition the body already implies — and, decisively, **the Q-3
repair's own consequence recital rests on additivity**. Publishing a strengthening
that leans on additivity immediately beside an unconditioned additivity headline
is the same defect twice, which is the exact phrase I used at `-0042` §5 when I
refused to publish dv's corollary unconditioned. So it is repaired, in the same
diff, and it is **named in the row and here as the round's one edit the dispatch
did not literally commission** — separable from every other edit, nothing else
depends on it, and it is the one to bounce if the write set is read more narrowly.
That is the `-0042` Date-column-note precedent, applied a second time with the
same declaration.

#### 6. Why the class column of the `Q-3` row does not say "the same function on the domain", and why that is this round's own lesson

`FINDING Q-4` is this round's other act, so the classification of the `Q-3` repair
is written under its shadow deliberately. **The same-function ground is not
available here and is not offered**: the retired and amended defaults give
different answers at precisely three port pairs, which is the whole point of the
repair. Offering it would repeat, in the very round that sustains `Q-4`, the error
`Q-4` convicts.

The ground offered instead is that the retired default was **false** at those port
pairs and that **nothing was built on the falsehood**, checked and not assumed:
no wrapper §7 pins a transmit per-octet constant (all three read this round);
§0.5's injection licence is gated behind *"a fact about the module, stated in its
own §7"*, which none of the three states; and **no committed instrument computes a
wrapper composite at all** — dv measured that at `J-dv_lead-0181` §6, `word_cycles`
having no caller outside its own module, its own test and M03's benches. So no
conformant design is admitted or excluded that was not before, no cycle, ceiling,
allocation or §1.1 row moves, and no committed test changes meaning. **Normative
text, editorial in effect, on a ground that names its own extension change rather
than denying it.**

**Not E2** — no requirement, phase or role added or dropped, no ceiling and no
allocation moved. **No ADR**, on the parent's precedent: the `C-RL-8`
term-versus-scope ruling was a rule change of the same kind and recorded its
refused alternative in §13 rather than in `docs/adr/`; the three cures and the
ground for refusing cure 2 are recorded in the row, which is what that precedent
requires. I flag the question rather than settling it silently — a ledger row
carries it — because "the parent did it this way" is a precedent and not an
argument, and the next rule change of this size should either follow it knowingly
or break it with an ADR.

#### 7. Act 4 — the ledger, advanced where it moved and restated where it did not

- **Item 44 — CLOSED.** The block's preamble said every gate checklist *"and every
  `SO-<module>.md` sign-off section"* instantiates §3's block **verbatim**, and the
  sentence three lines below it says a module sign-off instantiates **Part A
  only**, Part B's four boxes appearing as a named deferral line. The two cannot
  both be followed: an `SO-` copying the block verbatim renders four boxes
  ADR-0018 §A2.2 forbids it to render, and — because *"a gate is not passed while
  any box is unchecked"* — would be incomplete on all four for the life of the
  packet. "Verbatim" is true of a gate and false of a packet, and it is now said of
  each separately, with the struck reading quoted in place. Five rounds carried;
  the fix needed a dispatch that included `docs/gates/`, and this one did.
- **Item 11 / A2.4's gate-file edits — verified against the record, NO RESIDUE, and
  the item stays closed.** `git show --stat 61e0c76` is `J-architect_docs_lead-0037`
  and carries `docs/gates/P1-module-ready-checklist.md` (new, 555 lines) and
  `docs/gates/lessons-harvest-block.md` (+54/−14) — both halves landed in that one
  commit. I re-read `lessons-harvest-block.md` whole this round for item 44 and
  found the A2.4 material present: seat-qualified `LC-`/`LD-` ids with independent
  numbering (§1 step 2), the A2-D4 dual-site transcription rule (step 4), the
  no-deleted-rows / nil-yield rule (step 5), Part A's seven boxes, and the A2-D1
  substitute line. **Item 44's defect is not A2.4 residue** — it is an older
  sentence A2.4's edits did not reach — and I say so because the dispatch's *"if
  any residue remains"* invited exactly the wrong conclusion from a single
  co-located defect.
- **Item 50's third slice — exercised twice more this round, and it returned a
  finding on both runs.** The slice is *for each normative clause, enumerate the
  modules it quantifies over and evaluate it at each*. dv ran it on **REQ-016**
  and returned `FINDING Q-4`; I ran it on **the ΔC-additivity bullet** and returned
  §5's defect. With `-0042`'s run on q's default that is **three clauses, three
  findings, three for three**. A slice with that hit rate is not a note; it is a
  round that has not been scheduled, and the item now says so with all three
  instances named. It is also the strongest argument yet that the residue is large:
  §0.5 has roughly a dozen clauses of this shape and three have been walked.
- **Item 53 — narrowed, not closed** (§3 above). q's subject is corrected to the
  port pair because the repair is incoherent otherwise; h and the two tests still
  say *"the module"* and are untouched. The item's fourth instance is repaired at
  one quantity and its residue is the §0.5 scoping round it has always named.

#### 8. What I did not do, listed because a write permission is a promise

`docs/specs/modules/**` was permitted *"ONLY where an act above convicts a
file"*. Four module files are touched and each is named with its convicting act:
`arp_cache.md` (act 2, `FINDING Q-5`), `udp_complete_64.md` and `nic_top.md`
(act 3 — dv's exposure ranking names them as the unguarded pair). `ip_complete_64.md`
is **not** touched: M16 is already guarded, and adding anything there would be
enumeration. `eth_axis_tx.md` and `ip_eth_tx_64.md` are **not** touched: `Q-4`
convicts a §13 class cell in `requirements.md`, not those modules' §10 hooks,
which are correct as written and are the *evidence* for the finding rather than
its subject. **`docs/gates/P1-spec-freeze-checklist.md` is not touched**: ledger
item 12 lives there, the dispatch named four ledger items and item 12 is not among
them, and *"do not invent scope I did not name"* governs. Item 12 is now carried a
fifth round and I record that rather than quietly taking it while the door was
open.

### Actions

1. Ran the abort-first precheck; both outputs matched the dispatch exactly. Read
   HEAD again at the end: unmoved at `fef90b3`, so the declared-sibling
   re-verification clause was armed and unused.
2. Read the charter and PROTOCOL in full, then `J-dv_lead-0181` whole and
   verbatim, then §0.5 and §13 whole at HEAD, before writing anything.
3. **Measured REQ-016's domain at the source** — SPEC-M07 §10 and SPEC-M15 §10 —
   and **SUSTAINED `FINDING Q-4` whole**, adopting dv's proposed ground and
   refusing dv's proposed cure *location* on §13's own frozen-record rule.
4. **SUSTAINED `FINDING Q-5`** and repaired `arp_cache.md` §7 — one symbol,
   `(L + h)/8` → `(L + h − q)/8` — with the forced §13 preamble correction and
   the stale §12 `DRAFT` claim left standing and tracked.
5. **Repaired `FINDING Q-3`** in `requirements.md` §0.5: q's subject corrected to
   the port pair; the default **halved** (cure 1) so silence assigns zero only
   where the rule holds and assigns nothing elsewhere; a new normative
   structural-wrapper clause reading the existing definition at a wrapper; the
   closure result stated **as a consequence, not a definition** (cure 2 refused,
   its content kept); and the false Phase-1 census sentence replaced.
6. **Qualified the ΔC-additivity bullet** with its condition and the exact
   correction term, declared as the round's one uncommissioned and separable edit.
7. **Guarded SPEC-M19 §7 and SPEC-M20 §7** — the unguarded pair of dv's inverted
   ranking — naming the transmit figures as event delays, forbidding the
   conversion, stating each port pair's q = 2, and **pinning no constant**.
8. **Appended three `requirements.md` §13 rows** (`Q-4` adjudicated, `Q-5`
   sustained, `Q-3` repaired) and **three module change-log rows** (SPEC-M12,
   SPEC-M19, SPEC-M20 — the first post-freeze row in each).
9. **Closed ledger item 44** by repairing `docs/gates/lessons-harvest-block.md`'s
   preamble, and **verified item 11 / A2.4 against `61e0c76`**: both halves landed,
   no residue.
10. Re-derived every wrapper figure, the closure theorem and the additivity
    correction in a throwaway script; re-ran the retired-form census; checked
    every edited table's field counts.
11. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no git write
    of any kind.**

### Evidence

Reproducible from a checkout at this commit unless stated otherwise.

**Precheck and post-check — the sibling did not fire.**

    git status --short              # at entry: empty; at exit: the five files below
    git rev-parse HEAD              # at entry AND at exit: fef90b35d8b484174d9fe4a603045be3edc1954d
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # entry 15:52:38Z, exit 16:10Z

**`FINDING Q-4`'s domain, measured at the source and not taken from the filing:**

    grep -n "REQ-016" docs/specs/modules/eth_axis_tx.md docs/specs/modules/ip_eth_tx_64.md

returns a §10 coverage row in **each** file whose hook ends *"A bench SHALL NOT
assert a single per-octet latency here: M07 [M15] fails §0.5's straddle test
(§7)"* — `eth_axis_tx.md:534` and `ip_eth_tx_64.md:817` at HEAD. REQ-016's
requirement sentence (`requirements.md:777` at HEAD) binds *"every receive-path
stream (§0.4) **and every internal frame stream**"*.

**Every figure this round asserts, re-derived by arithmetic** (throwaway script,
outside the repository, not staged; the same numbers are checkable by hand from
SPEC-M15 §7, SPEC-M09 §7, SPEC-M07 §7, SPEC-M18 §7, SPEC-M04 §7):

    M16: children M15(L28,I20) M09(L0,I0) M07(L22,I14)
         L=50 h=0 I=34 q=2 (L+h-q)=48 mult8=True dC=6   [default q=0 -> 50/8 = 6.25]
    M19: children M18(L8,I8) M16(L50,I34)
         L=58 h=0 I=42 q=2 (L+h-q)=56 mult8=True dC=7   [default -> 58/8 = 7.25]
    M20: children M19(L58,I42) M05/M04(L16,I8)
         L=74 h=0 I=50 q=2 (L+h-q)=72 mult8=True dC=9   [default -> 74/8 = 9.25]

    closure theorem, sum(Li+hi-qi) mod 8 per chain:  M16 0, M19 0, M20 0
    additivity, sum(dCi) + floor(sum(qi)/8) vs composite dC:
         M16: 5 + 1 = 6 = 6      (qi = 4,0,6 -> sum 10, carry 1)
         M19: 7 + 0 = 7 = 7      (qi = 0,2   -> sum  2, carry 0)
         M20: 9 + 0 = 9 = 9      (qi = 2,0   -> sum  2, carry 0)
         M19 decomposed to leaves: 6 + 1 = 7 = 7   (qi = 0,4,0,6 -> sum 10, carry 1)

Every figure `-0042` filed is confirmed, dv's independent derivation of the same
nine is confirmed, and the additivity correction is checked in **two**
decompositions of M19, which is what makes it a formula rather than a coincidence.

**The retired-form census, re-run after this diff:**

    grep -rc "(L + h)" docs/specs/ | grep -v ":0"
    # requirements.md 6      — ALL inside §13 (header at line 1188), frozen record
    #                          + this round's three new rows quoting the form to convict it
    # SPEC-TEMPLATE.md 1     — inside the prohibition that names the form to forbid it
    # arp_cache.md 1         — this round's own §13 row quoting the retired clause (line 396 repaired)
    # nic_top.md 4           — three class-A receive-chain evaluations (q = 0) + this round's §13 row
    # eight other module files 2–3 each — class-A per-module evaluations at q = 0, upheld, untouched
    grep -n "(L + h" docs/specs/modules/arp_cache.md   # 396: (L + h − q)/8   [repaired]

**Table integrity**, by a field-count pass over every change-log table this round
touched: `requirements.md` §13 — **65 rows, all 6 fields**; `arp_cache.md` §13,
`udp_complete_64.md` §13, `nic_top.md` §13 — **3 rows each (header, rule, one
data row), all 5 fields**; `ip_complete_64.md` §13 unchanged at 4. Zero
malformed rows in any of the five.

**Ledger item 11 / A2.4, verified against the record:**

    git show --stat 61e0c76
    # J-architect_docs_lead-0037; docs/gates/P1-module-ready-checklist.md (new, 555 lines)
    #                             docs/gates/lessons-harvest-block.md      (+54/-14)

Both halves in one commit; `lessons-harvest-block.md` read whole this round and
the A2.4 material is present (§1 steps 2, 4 and 5; Part A's seven boxes; the
A2-D1 substitute line at §3). **No residue.**

**Nothing in this entry is a verification result about any module.** Every
quantity is derived from a specification and checked against another specification
or against arithmetic; no RTL, no test and no bench was read, and no `SO-` is
opened or offered. `dune` was not invoked and no claim here depends on it
(ADR-0005).

### Outcome

**DoD met on all four acts.**

1. **`FINDING Q-4` SUSTAINED whole**, its ground measured at SPEC-M07 §10 and
   SPEC-M15 §10, dv's proposed correct ground adopted as stated, and the cure
   landed as a **new §13 row beside the cell it corrects** rather than inside it —
   the substance dv's, the location this table's own frozen-record rule.
2. **`FINDING Q-5` SUSTAINED and cured** — one symbol at SPEC-M12 §7, with a
   module-side §13 row so a reader of that document meets the correction where it
   lives, and one stale status claim found, left standing and tracked.
3. **`FINDING Q-3` REPAIRED.** Cure 1 taken as a **halving** of the default; **dv's
   closure theorem TAKEN** and re-derived, which is what makes cure 1 the whole
   cure; **cure 2 REFUSED** on dv's argument (my own Ground 2 one level up) with its
   content kept as a stated **consequence** rather than a definition; **cure 3
   subsumed**. q's subject corrected to the port pair, the false Phase-1 census
   sentence replaced, the ΔC-additivity headline qualified with its exact
   correction term, and the **unguarded pair M19 and M20 guarded** on dv's inverted
   exposure ranking — neither pinning a constant.
4. **Ledger: item 44 CLOSED; item 11 / A2.4 verified with no residue; item 50's
   third slice at three-for-three and named as an unscheduled round; item 53
   narrowed at one quantity, not closed.** Item 12 deliberately not taken and
   carried a fifth round, with the reason recorded.

**Handoff**: to the orchestrator for commit. **Countersignature-owing diff, marked
for routing**: the whole `requirements.md` **§0.5** diff — the halved default, the
port-pair subject, the structural-wrapper clause, the closure consequence, the
amended Phase-1 census sentence and the **ΔC-additivity qualification** — to
**dv_lead**, whose closure theorem it takes and whose cure-2 argument it applies.
It is **IN FORCE meanwhile**, because the retired default is the one that convicts
conformant designs while the amended one convicts nothing. The two **module
guards** (SPEC-M19 §7, SPEC-M20 §7) ride the same routing as consequences of it,
and dv should read them for whether a guard that names a q without pinning a
constant is the right instrument. **Owing no countersignature**: the `Q-4` and
`Q-5` §13 rows and the SPEC-M12 repair — the first records a ground correction and
moves no requirement text, the second is one symbol at a module with no instance
of the quantity — and the `docs/gates/` preamble repair. **To dv_lead besides**:
`FINDING Q-4`'s cure is delivered in a different **location** than dv proposed and
dv may contest that; and §5's additivity defect is a fourth member of the family
`Q-1`/`Q-2`/`Q-3` belong to, found by dv's own `LH-0181-1` method applied to a
clause dv has not read.

**Carried ledger, restated whole** (this chain's practice at every entry, not only
at a volume boundary; every row carries an owner and a closing event, so a row is
never a note to nobody). Items 1–64 are carried from `-0042` with their
dispositions; only the rows this round touched carry new text.

| # | Item | Owner | Closing event | This round |
|---|---|---|---|---|
| 1 | ADR-0016 §8's transcription mechanic is unwritten in PROTOCOL | orchestrator | a PROTOCOL §11 amendment | carried |
| 2 | The generic shell's `LESSONS` transit is the orchestrator's and unexercised | orchestrator | the first harvest reaching the shell | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; half spent |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | carried — **no volume boundary this round** (v04 at 59,493 bytes against a 262,144 soft max), so the obligation is not triggered; the ledger is restated below anyway, which is the practice this item wants written down |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace | me | an ADR-0018 amendment, or the collator ruling a scheme | CLOSED at `-0036` |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried |
| 9 | `agents/journals/INDEX.md` stale, silent on volumes | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried — and now silent about a **fifth** journal volume in the program, dv having opened v10 at `9a596e7` |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate | CLOSED at `-0037` — **re-verified this round against `61e0c76`**: the file landed there (555 lines) together with A2.4's edits to `lessons-harvest-block.md` (+54/−14). **No residue.** The item stays closed and item 44's defect is an older sentence, not A2.4 leftovers |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried — **fifth round running, and this is the first in which the write set permitted `docs/gates/` and I still did not take it**, deliberately: the dispatch named four ledger items and this is not one of them. Recorded so the omission is a decision rather than an oversight |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are different dispositions | me | any WO next opening `requirements.md` §0.6 | CLOSED at `-0039` |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried — this round opened `requirements.md` at §0.5 and §13 and not §0.6; it remains the oldest untaken §0.6 item |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried — **fifth consecutive round that opened `requirements.md` and did not take it** |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried |
| 25 | Two re-countersignatures and one concurrence owed at `-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling | me | reading whether dv tightened G6's window | carried, still unchecked |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried — **seventh customer**; this round edits §0.5's q paragraph and the ΔC bullet and leaves REQ-016's text alone entirely (only its §13 *ground* is corrected) |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | CLOSED at `-0038` |
| 30 | `AP-xgmii_rx_64.md` §4.I's cells and `FINDING SO-1-A`'s §6 repair are dv's | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger. **This round did not touch REQ-016's text at all** — the `Q-4` cure corrects a §13 class cell — so the option is neither advanced nor foreclosed |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes | dv_lead (carrier); me (class) | a record-only run, then a class round | carried |
| 35 | Repairs that correct dv's findings rather than my own text, unseen by dv | dv_lead | dv reading them, disputing or not | carried — **and this round adds a seventh and an eighth**: `Q-4`'s cure is delivered in a **different location** than dv proposed (a new row, not an edited cell), and §5's ΔC-additivity defect is one dv has not read at all |
| 36 | The `-0032` countersignature is owed | dv_lead | dv countersigning | CLOSED at `4e7331b` |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar | me (class); dv (stimulus) | a class ruling | carried |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | **carried, third instance, and it is now load-bearing rather than observational.** `FINDING Q-4`'s cure turns on it: dv asked for one sentence *in* the offending class cell and got one *beside* it, because a cell edited in place erases the fact that a wrong ground was once offered. *A record is corrected beside itself, never rewritten* has three independent instances and should be stated as a rule at the next harvest |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` | me | the next round opening `docs/gates/` | CLOSED at `-0037`; **re-verified this round against `61e0c76` and by reading the file whole — all five present, no residue** |
| 43 | A2 binds without countersignature; a contest is carried to an Amendment A3 | any contesting seat; me for drafting | a re-verdict without contest, or an A3 landing | carried, half spent |
| 44 | The block's preamble still says an `SO-` instantiates §3's block *"verbatim"* | me | the next round opening `docs/gates/lessons-harvest-block.md` | **CLOSED.** Five rounds carried, and the fix needed exactly what it always said it needed: a dispatch whose write set included `docs/gates/`. The preamble now says *verbatim* of a **gate** and states the `SO-`'s one prescribed substitution separately, with the struck reading quoted in place. The defect was self-contradiction across four lines, not ambiguity |
| 45 | The `P1-module-ready` checklist's ledger `G-1 … G-11`; five rows are mine | me for those five | each `G-` row's own closing event | carried — **`G-3` gains material again**: three more frozen specifications take post-freeze diffs (SPEC-M12, SPEC-M19, SPEC-M20 — the **first** post-freeze row in each) and **all three are editorial**, so the post-freeze churn count still does not move. Eight frozen specs have now taken editorial post-freeze diffs and none has taken a breaking one |
| 46 | REQ-904's commissioned CI set-equality script does not exist | dv_lead (`tools/` scope); me for the `WO-` request | the script landing green | carried — **this round adds no REQ id**, sixth round running |
| 47 | Three countersignatures owed on `-0038` | dv_lead | dv countersigning each | CLOSED at `-0039`; re-checked here: this round leaves REQ-210, REQ-016's text and the inserting-module clause untouched. Stays closed |
| 48 | `AP-xgmii_tx_64` §8 item 2: REQ-901 declares no divergence class at the M04 boundary | me (the record); orchestrator (the sequencing) | the vendoring commit, then a derivation round | carried; the spec half stays fully discharged |
| 49 | `AP-xgmii_tx_64` §8 item 3 makes `C-5` a dependency of a landed plan | me | the §0.6 round item 14 named | CLOSED at `-0039` |
| 50 | **A closed ledger item can be reopened by a later ruling, and nothing detects it** | me | a survey of closed items whose grounds cite a since-amended §0.5/§0.6 clause | **carried, and its third slice is now three-for-three.** The slice — *for each normative clause, enumerate the modules it quantifies over and evaluate it at each* — has been run on three clauses and returned a finding on each: q's default (`-0042` → `FINDING Q-3`), **REQ-016** (dv, `J-dv_lead-0181` §3 → `FINDING Q-4`) and **the ΔC-additivity bullet** (this round → §5's defect, repaired here). §0.5 has roughly a dozen clauses of this shape and three are walked. This is no longer a note; it is an unscheduled round, and the ledger says so |
| 51 | `FINDING CSG-1`'s four cases have never been checked against a run | dv_lead (the run); orchestrator (scheduling) | the first record-only run | carried, unchanged |
| 52 | SPEC-M04's own §11.3 carries `C-5` as a deferred item | me | the `C-5` round of items 14 and 49 | CLOSED at `-0039` |
| 53 | §0.5 states its two tests as properties of a module, and a module may pass them at a port where the stimulus they quantify over has no instance | me | a `requirements.md` §0.5 round, or a deliberate decision to leave the statement at the module | **NARROWED, not closed.** The fourth instance is repaired at **one quantity**: q's subject is now the **port pair** it is measured across, because the `Q-3` repair is incoherent otherwise (a wrapper has q = 2 at its transmit ports and 0 at its receive ports, and dv's REQ-019 walk depends on the second). **h and both tests still say *"the module"* and are untouched** — that is a larger normative change and is the §0.5 scoping round this item has always named. The item's subject is now sharper than its title |
| 54 | Class (h)'s REQ-110 half now has no comparing-run instance | me (the class); dv_lead (an observation) | the class round of item 34 | carried, unchanged |
| 55 | Two countersignatures owed on `-0039` | dv_lead | dv countersigning each | CLOSED, both halves, at `747e561` |
| 56 | **The `AP-M14-1` adjacency stands unscoped at four other specifications** — SPEC-M06, SPEC-M17, SPEC-M16, SPEC-M19 | me | a round per specification, or one batch round | carried — **and this round opened SPEC-M19 for a different reason and did not take it**, on the same rule as `-0042`'s refusal at SPEC-M16: one round, one question per specification |
| 57 | **SPEC-M17 §7 and SPEC-M08 §7 still carry the retired *"delay everything by exactly 8 octet times per cycle"* sentence** | me | the round that opens SPEC-M17 §7 | carried, unchanged — this round opened neither |
| 58 | One countersignature owed on `-0040`: the §0.6 `ABS-1` diff | dv_lead | dv countersigning | CLOSED at `2a0a2b1` |
| 59 | **Two specifications compose M07's and M15's §7 figures under a name those bullets no longer use exclusively** | me | the round that next opens SPEC-M16 §7 or SPEC-M13 §6.1 | CLOSED, both halves, at `-0042`, with the item's own verdict convicted at one of them |
| 60 | **One countersignature owed on `-0041`**: the §0.5 output-offset diff | dv_lead | dv countersigning | CLOSED at `500dbed`, transcribed at `0092325` |
| 61 | **This chain's header stamps run fast, non-uniformly, and reach eight dated rows of `requirements.md` §13** | me (the record); orchestrator (the program-wide ruling); auditor (the process item) | nothing repairs the past; the closing event is the auditor's process finding and the honest-stamp practice holding for a run of entries | carried — **third consecutive honest stamp** (`-0041`, `-0042`, this entry), and this round's six new dated rows all carry the commit's own UTC date. A run of three is not yet the closing event, and I will not call it one |
| 62 | **`FINDING Q-3`: §0.5's output-offset default is false at every structural wrapper whose children insert** — M16, M19 and M20 each carry a composite q = 2 | me | the §0.5 scoping round of item 53, which must choose among the three live cures | **CLOSED — repaired this round.** dv **CONCURRED**, sustained MINOR, and supplied the **closure theorem** that made the choice easy: a composite of conformant children satisfies the whole-number test identically, so the default is the only thing that can make a conformant chain fail it, and repairing the default is the whole cure. **Cure 1 taken** (the default halved), **cure 2 refused** on dv's argument with its content kept as a stated consequence, **cure 3 subsumed**. The two unguarded siblings M19 and M20 are guarded on dv's inverted exposure ranking. The countersignature this repair owes is item 67 |
| 63 | **`SPEC-TEMPLATE.md` §7 does not instruct an author to state §0.5's two test verdicts** (straddle, late decision) | me | a template round, or the §0.5 scoping round of item 53 | **carried, and it gains a second limb**: after this round the template also does not tell a **structural wrapper's** author that a port pair inserting through its children has an unstated q which the author now owes. The template is the generator `FINDING Q-1` convicted once already, and it is now one round behind §0.5 in two places |
| 64 | **Two countersignatures owed on `-0042`** | dv_lead | dv countersigning each | **CLOSED, both, at `9a596e7`** (`J-dv_lead-0181`), transcribed at `fef90b3` (`J-orchestrator-0256`). REQ-019 signed on my ground **and a stronger one**; REQ-016's **text** signed and its **stated ground REFUSED** as `FINDING Q-4` (this round's item 65); `Q-2`'s bullet and corollary signed on independent re-derivation with both premises verified in the two D-tables |
| 65 | **`FINDING Q-4` (MINOR, dv_lead)**: one editorial ground offered for two normative sites, true at REQ-019 and false at REQ-016 | me | the cure landing | **new, and CLOSED this round.** Sustained whole; dv's proposed ground adopted as stated; cured as a **new §13 row beside** the cell it corrects rather than inside it, on this table's own frozen-record rule (item 41). dv may contest the location; the substance is not in dispute |
| 66 | **`FINDING Q-5` (MINOR, dv_lead, against dv's own class-A call)**: SPEC-M12 §7's no-instance recital stated the retired conversion as a general rule | me | the cure landing | **new, and CLOSED this round.** One symbol at `arp_cache.md:396`, plus that module's **first post-freeze §13 row** so its own reader meets the correction. The generalisable half is dv's `LH-0181-3` and I have recorded it in the row rather than only here |
| 67 | **One countersignature owed on this round**: the whole `requirements.md` §0.5 diff — the halved default, the port-pair subject, the structural-wrapper clause, the closure consequence, the amended Phase-1 census sentence and the ΔC-additivity qualification | dv_lead | dv countersigning | **new this round.** The diff is **IN FORCE meanwhile**: the retired default is the one that convicts conformant designs while the amended one convicts nothing. The two module guards (SPEC-M19 §7, SPEC-M20 §7) ride the same routing as consequences. The `Q-4` and `Q-5` rows, the SPEC-M12 symbol and the `docs/gates/` preamble owe none |
| 68 | **The ΔC-additivity bullet said *"ΔC is additive along a chain"* without condition, and it is false at a chain whose stages insert** | me | dv countersigning item 67, which contains it | **new this round, and it is the round's one edit the dispatch did not literally commission** — separable from every other edit, nothing else depending on it, and the one to bounce if the write set is read narrowly. Repaired rather than filed because the `Q-3` repair's own consequence recital rests on additivity, and publishing a strengthening beside a false additivity headline is the same defect twice. Measured: Σ ΔCᵢ = 5 at M16 against a composite ΔC of 6; the exact correction is ⌊Σ qᵢ / 8⌋, which is the same carry the closure theorem discards mod 8 |
| 69 | **SPEC-M12 §12 says *"this spec is DRAFT"* against the document's own FROZEN header and against §12's own `Frozen at` row (SHA `3f6accc`)** | me | the round that opens SPEC-M12 §12 | **new this round**, found because landing M12's first post-freeze §13 row falsified that section's *"has none"* and forced its preamble. §13's stale claim is repaired as a consequence; **§12's is left standing and flagged in §13's preamble in one parenthesis**, because a status claim is not a change-log row's subject and repairing it inside a round commissioned for one symbol is how scope creeps |
| 70 | **Whether a requirements-level rule change of this size owes an ADR** | me | an explicit ruling, or the next such change taking one | **new this round.** No ADR is written, on the parent's precedent: the `C-RL-8` term-versus-scope ruling recorded its refused alternative in §13 rather than in `docs/adr/`, and the three cures and the ground for refusing cure 2 are recorded the same way here. **A precedent is not an argument.** The next rule change of this size should either follow it knowingly or break it with an ADR, and this row exists so that choice is made rather than inherited |

- **No harvest note is owed** — PROTOCOL §7 and charter §8 attach it to an `SO-`
  and to a phase gate, and this round is neither. Declared rather than omitted.
  The open span for my next harvest continues to run and this entry joins it.
- **No escalation.** **E2 not triggered**: no requirement, phase or role added or
  dropped; no ceiling, allocation or §1.1 row moves; the §0.5 repair withdraws a
  false assignment rather than admitting or excluding any design, and both module
  guards pin nothing. Item 33 remains the only E2 on this ledger. **E3 not
  triggered** — no toolchain or licensing surface reached. **E5 not triggered** —
  every finding this round is sustained or concurred; there is no disagreement
  between leads except the **location** of `Q-4`'s cure, which is one round of one
  sentence and not a deadlock.

### Open-questions

1. **`FINDING Q-4`'s cure is delivered in a different location than dv asked for,
   and dv should say whether that is acceptable.** dv asked for one sentence *in*
   the offending class cell; it is one row *beside* it, on §13's own frozen-record
   rule and ledger item 41's disposition. My ground is that a cell corrected in
   place erases the fact that a wrong ground was once offered — the half a reader
   auditing the sweep most needs. If dv reads the frozen-record rule as applying to
   *values* and not to *grounds*, that is an argument I would want to hear before
   the practice hardens into a third and fourth instance.
2. **§5's ΔC-additivity defect is a fourth member of the `Q-1`/`Q-2`/`Q-3`
   family and dv has not read the clause.** It was found by dv's own
   `LH-0181-1` method — take a statement's headline, enumerate the domain from the
   text that defines it — applied to the bullet next door to the repair. It is
   repaired rather than filed, with its ground stated, and it is inside item 67's
   countersignature. If dv would rather have had it filed, the row and this
   Open-question are where to say so.
3. **The template is now one round behind §0.5 in two places** (item 63). It does
   not tell an author to state §0.5's two test verdicts, and it does not tell a
   structural wrapper's author that a port pair inserting through its children owes
   a q the specification must state. `SPEC-TEMPLATE.md` §7 is the generator
   `FINDING Q-1` convicted once already for exactly this lag, and the second lag is
   larger than the first because the new obligation has three live subjects in
   Phase 1 today.
4. **Item 50's slice is three-for-three and is still not scheduled.** Three
   normative clauses walked, three findings — `Q-3`, `Q-4`, and §5's. §0.5 has
   roughly a dozen clauses of that shape. Continuing to discover these one at a
   time, each inside a round commissioned for something else, is how a defect
   family gets a name instead of a survey. The survey is a round and it should be
   dispatched as one.
5. **The three wrappers are now labelled holes rather than wrong values, and that
   is a state, not a resolution.** M16, M19 and M20 each say they pin no transmit
   per-octet constant and forbid the conversion; the composites are derived in
   `requirements.md` §13 and pinned nowhere. That is the honest position while the
   governing §0.5 diff awaits countersignature, and the alternative — pinning
   L = 50 / 58 / 74 with q = 2 in an uncountersigned round — remains the worse
   error. But a derivable, unpinned transmit latency is still an invitation to
   derive it wrongly, and the round that closes item 67 should pin all three or say
   in terms that it will not.

### Files-in-this-commit

- docs/specs/requirements.md
- docs/specs/modules/arp_cache.md
- docs/specs/modules/udp_complete_64.md
- docs/specs/modules/nic_top.md
- docs/gates/lessons-harvest-block.md

## [J-architect_docs_lead-0044] 2026-08-11T16:47Z | task:none | Three narrowings cured at the sentences they were filed against, the conflation found at a fifth site and closed by a census keyed on the class rather than on its symptom — and the fourth act, commissioned as outstanding, found already discharged and adjudicated rather than performed twice

### Trigger

Orchestrator dispatch, one round, four acts: the three findings dv_lead filed
while paying the second countersignature on my `43c0087` round — `FINDING Q-6`,
`FINDING Q-7`, `FINDING Q-8` — and the minting of `FINDING Q-4`'s cure, which the
dispatch describes as an act my own rule now licenses. **The fourth act was
already discharged**, at `43c0087`, and §7 below adjudicates that rather than
performing it a second time. Two ledger items were offered optionally and I name
what I took of each.

**Abort-first precheck, before any file was opened.**

    git status --short              # empty
    git rev-parse HEAD              # b29d2ebf30278ad2a4f4689fa5e0f6b87825d773
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 16:35:57 UTC 2026

Byte-equal to the dispatched spawn-head `b29d2eb`, tree clean, so neither branch
of the abort procedure was reached. The dispatch declares **two** siblings in both
directions: the auditor on a concurrent PROCESS round (its own journal and its own
audit-ledger artifacts only, reading my committed heads), and the orchestrator's
possible board flip (`tasks/BOARD.md`, `site/**`, its journal).

**Neither sibling fired.** HEAD was re-read before the first write and again at the
end and is `b29d2eb` at both, so the re-verification clause was armed and unused
for the second consecutive round. I record the negative for the same reason
`-0043` did: a chain that only ever reports "it fired and I re-verified" makes the
quiet round look like an omission, and the arrangement costs one command when
nothing moves.

**No rotation.** v04 stands at 120,192 bytes against `JOURNAL_SOFT_MAX` = 262,144
(ADR-0017 §5), so this entry appends to the volume `-0042` opened. The ledger is
restated whole below, which is this chain's practice at every entry and not only
at a boundary (item 4).

**Honest stamp.** The header stamp is `date -u` read at the moment of writing
(16:47:03Z, rounded to the minute), and the six dated rows this round appends —
four in `requirements.md` §13, one in SPEC-M05 §13, and the struck-reading date
inside SPEC-M05 §7 — all carry that same UTC date. **Fourth consecutive honest
stamp on this chain** (`-0041`, `-0042`, `-0043`, this entry) against thirty-seven
historical entries that were not (item 61).

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md`, in full,
  before any other file (§3 packet classes and the relay rule, §4/§4.1 entry
  grammar, §4.2 set-equality, §5 R1–R9, §6 write scope, §7 gates and the harvest
  clause, §8, §10, §11).
- **`agents/journals/claude_dv_lead_agent.v10.md`, `J-dv_lead-0182` in full and
  verbatim** — Trigger (including its own sibling-clause exercise across
  `43c0087` → `8babb6b`), Inputs, Reasoning 1–10, Actions 1–13, Evidence
  (including the five-decomposition table, the exhaustive refusal search and the
  four-module straddle table), Outcome with its item-by-item verdict table and its
  two banked harvest candidates, and Open-questions 1–9. Read at the source, not
  through the dispatch's summary: §5 is `FINDING Q-6`, §6 is `FINDING Q-7`, §9 is
  `FINDING Q-8`, §10 is the `Q-4` concurrence, §2 is the straddle measurement that
  bounds ledger item 53 and §4 is the inherited-premise naming.
- **`docs/specs/requirements.md` at HEAD**: §0.5 **whole** — octet time, latency,
  the front offset h paragraph, the inserting-module clause, the q paragraph group
  (subject, halved default, the recital, REQ-021, the structural-wrapper clause,
  the closure consequence, the Phase-1 census sentence), the identity, *Why a term
  and not a scope*, *Provenance and authority*, **Word delay ΔC** with its three
  consequence bullets, **Cycles**, **Gapped stimulus** and the deciding-input-word
  paragraph — plus **§0.4 whole** (the **Structural modules** paragraph is the
  domain both cures are checked against) and **§13's whole table**, in particular
  the `FINDING Q-1` sweep row, the `Q-4` correcting row of `43c0087` and the
  orchestrator's transcription row of `b29d2eb`.
- **`docs/specs/modules/eth_mac_10g.md` whole** — header, §1, §2, §3, §7, §8, §9,
  §10, §11, §12 and §13 — the `FINDING Q-8` site and the module whose status
  claims and change log the cure moves.
- **`docs/specs/modules/xgmii_tx_64.md` §7 whole** — M04's five-row table (event
  delay 8 octet times = 1 cycle, L = 16, h = 0, ΔC = 2), its *"why h is 0 at a
  module that inserts"* paragraph, its both-ways derivation and its
  `FINDING AP-M04-2` prohibition, which the M05 cure relays.
- **The leaf §7s every figure is re-derived from**: `eth_axis_tx.md` §7 (M07:
  L = 22, h = 0, I = 14, q = 6, ΔC = 2), `ip_eth_tx_64.md` §7 (M15: 28, 0, 20, 4,
  3), `eth_arb_mux.md` §7 (M09: 0, 0, 0), `udp_ip_tx_64.md` §7 (M18: L = 8,
  I = 8, and its explicit statement of *both* figures).
- **The three wrappers' §7s at HEAD** — `ip_complete_64.md`, `udp_complete_64.md`,
  `nic_top.md` — re-read to confirm the census claim that none pins a per-octet
  constant across its transmit ports.
- **`docs/specs/SPEC-TEMPLATE.md` §12 and its DRAFT/FROZEN paragraph**, and the
  §12 preambles of every module specification — the census behind ledger item 69.
- **My own `J-architect_docs_lead-0043` in full** — Reasoning 1–8, Actions,
  Evidence, the seventy-row ledger and Open-questions 1–5.
- **Not opened**: `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`, `test/**`,
  `tools/**`, `site/**`, `tasks/BOARD.md`, `docs/reports/**`. **No RTL and no
  bench reached this round.** Every quantity below is derived from a
  specification, checked against a second specification, and re-checked by
  arithmetic in a throwaway script whose output is in Evidence.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

#### 1. What a round of three narrowings owes that a round of three refusals would not

All three findings are against text that is **true and incomplete** rather than
false, and two of them are against sentences inside a diff the same entry
countersigned **whole**. That combination sets the standard for this round: a
narrowing is cured at the sentence it was filed against, in the clause the signer
specified, and **nothing else moves** — because the temptation with a
true-but-incomplete statement is to rewrite the paragraph around it, and a
paragraph rewritten in a repair round is a paragraph nobody countersigned.

Each cure below is therefore checked against three things before it is written:
the finding's own stated cure, the arithmetic (re-derived, not recognised), and
the set the sentence quantifies over, enumerated from the document that defines
the set rather than from the finding that produced it. That last check is dv's
`LH-0182-2` and it is the method that produced this round's one piece of new
work — §5's class-keyed census — and its one refusal, §8's.

#### 2. `FINDING Q-6` SUSTAINED — the correction is a property of the partition, and the partition a reader can build is the one the sentence got wrong

The bullet said the carry *"vanishes wherever Σ qᵢ < 8 — so along §0.4's receive
chain, where every qᵢ is 0, and at **M19 (0 + 2) and M20 (2 + 0)**"*. Σ qᵢ runs
over the stages of whichever partition is being summed, so the value named is
**one partition's answer**, and naming it by module denies the other partition's.
I re-derived rather than accepted, at all five decompositions (Evidence):

| composite | partition | Σ qᵢ | Σ ΔCᵢ | carry | ΔC |
|---|---|---|---|---|---|
| M16 | three leaves {M15, M09, M07} | 10 | 5 | **1** | 6 |
| M19 | two children {M18, M16} | 2 | 7 | 0 | 7 |
| M19 | four leaves | 10 | 6 | **1** | 7 |
| M20 | two children {M19, M05} | 2 | 9 | 0 | 9 |
| M20 | five leaves | 10 | 8 | **1** | 9 |

The composite's ΔC is decomposition-invariant — that is the formula's content —
and the split between the sum and the carry is not. So *"it vanishes at M19"* is
true of one partition and false of the other, and the finding is exactly right.

**What makes it more than a pedantry, and I verified the claim rather than taking
it**: my own `43c0087` guards leave M16, M19 and M20 **pinning nothing** in their
§7s (re-read all three this round — each says in terms that it pins no per-octet
constant across its transmit ports and forbids the conversion), and the composites
exist only inside `requirements.md` §13 rows. So the decomposition a reader
actually reaches **through module specifications** is the leaf one, which is
precisely the partition at which the correction is 1 at both named modules. A
reader who follows the sentence and sums the leaves gets ΔC = 6 at M19 and 8 at
M20 against the true 7 and 9. **The error is reached by following the text, not by
ignoring it**, which is the same property that made `SCR-M03-I4` expensive.

**The cure is the signer's, in the signer's own terms**, and I did not widen it:
one clause saying the correction is taken over the stages of the decomposition
summed, plus M19's two values as the worked instance — an instance that was
already in `-0043`'s Evidence block (*"M19 decomposed to leaves: 6 + 1 = 7"*) and
did not reach the text. I added two things and both are consequences rather than
extensions: M20's two values, because a worked instance that exists at both named
modules is what stops the next reader re-deriving it, and one sentence saying
**which partition a reader is on today and why** — the guards being the reason.
The formula, both its forms and the headline's condition are the countersigned
text and are **untouched**.

**Provenance, which the signer states against itself and I record because it is
the useful half.** The invitation is in the closure theorem's phrasing: it proves
a congruence mod 8, the bullet needed a quotient, and a congruence is exactly the
statement from which the carry has been divided out. Two statements derived one
from the other, one true and one over-general, is the same shape as `FINDING Q-1`
and `FINDING Q-2` — and this is the second time in three rounds that a theorem
adopted from the countersignatory has produced a defect in the text that adopted
it. That is not an argument against adopting them; it is an argument for
re-deriving them in the destination's own terms, which is what the signer did to
mine and what I did to this one.

#### 3. `FINDING Q-7` SUSTAINED — a census keyed on the symptom cannot see the member whose symptom is absent

The sentence enumerated three sets and **M05's transmit port pair is in none of
them**: not a receive-path port pair (§0.4 — *"their transmit ports are not
receive-path ports"*), not a **leaf** transmit port pair (M05 is structural), not
one of the three wrappers it names. §0.4's **Structural modules** paragraph names
**four**. I measured this at the source rather than accepting it, and the value
question separately: M05's transmit port pair inserts M04's eight octets, one
whole word, so q = 0 and the **first** clause of the halved default reaches it and
assigns it. **No value is wrong; the enumeration is short by one member** — in a
sentence whose entire content is an enumeration, standing where a census that was
false for the same reason had just been retired.

**Why M05 fell out is the part that generalises, and it convicts my survey and
dv's identically.** Both surveys were keyed on the symptom: mine on the wrappers
measured at q = 2, dv's on the wrappers ranked by exposure — and both of those
sets *are* the q ≠ 0 set. A census keyed on the value that triggered the finding
cannot see the member whose value is benign. So the cure is not only the missing
member: the sentence now says **in terms** that its enumeration is taken from
§0.4's own list rather than from the non-zero set, which makes it self-checking
against §0.4 instead of against a memory of which modules a finding named.

One thing I added beyond the signer's cure, and its reason. The sentence's closing
clause said *"none of the three pins a per-octet constant … across those transmit
ports"*. With M05 in the enumeration that clause needs a hand: M05 **does** pin its
transmit constants, and after §4's cure it pins them explicitly. Left unqualified,
a reader meets a four-member set and a prohibition that visibly fails at one
member, and has no way to tell whether the fourth is an exception or a defect. The
sentence now says the pin is **licensed and not an exception** — its figures are
its child's unchanged and its q is 0 — which is the same distinction §0.5 already
draws between a wrapper that inserts a fraction of a word and one that does not.

#### 4. `FINDING Q-8` SUSTAINED — an event delay pinned as a latency, at the wrapper both censuses were built to miss

SPEC-M05 §7 read *"its transmit-port constant is M04's, **8 octet times**
(SPEC-M04 §7)"*. SPEC-M04 §7 pins **two** constants and says in terms that naming
which is which is the requirement: REQ-210's **event delay**, 1 cycle = 8 octet
times, and §0.5's per-octet **latency**, L = **16**, with h = 0 and ΔC = 2. M05
pinned one figure, named neither, and did it in a clause built in exact parallel
with a receive-side clause that names L — so it reads as a latency, which is what
§0.5's inserting-module clause forbids in terms.

**The refutation is inside the bullet.** Its own first words are *"zero octet
times added, in both directions"*, and a module adding zero has its child's L.
M04's L is 16. So the sentence contradicts its own headline, and the contradiction
is arithmetic rather than interpretive: **8 ≠ 16**, and the error a composer
inherits is a factor of two in L, not a rounding. `C-RL-8`'s class at a **fifth**
site, and the first at a structural module.

**The cure is the signer's — name both figures — and I landed it in the form the
other four sites already use**: a table pinning the event delay and the latency
side by side with h, q and ΔC, the struck reading quoted in place with its date,
and the reason it survived stated. **One clause is mine and is not decoration.**
Pinning L at M05's transmit port pair, where nothing pinned a latency before,
would otherwise read as licensing what §0.5's closing paragraph licenses at a
module passing both tests — an idle-injection bench. SPEC-M04 §7 forbids exactly
that at exactly this interface (`FINDING AP-M04-2`: a source word required and not
presented is REQ-206's **underflow**, not a gap), and SPEC-M05 §7's own handshake
bullet already says REQ-016's idle tolerance does not extend to `tx_tready`. The
cure points at both rather than restating either. **A repair that cures a
conflation and silently opens a licence would be a worse round than the defect.**

**Nothing was built on the wrong figure, and I checked rather than assumed the
part I could check from `docs/`**: this table's own M20 transmit composite uses
**16**, SPEC-M05 §13 had no post-freeze row at all and its preamble restated only
the receive-side constants, so the transmit figure was untracked. dv measured the
`test/` side in its own lane and reports no committed test computing an M05
constant; that measurement is dv's and is cited as dv's.

#### 5. The census keyed on the class rather than on its symptom — the round's one piece of work nobody commissioned, and the reason it is cheap

dv's `LH-0182-2` says a survey keyed on a symptom systematically leaves standing
the members whose symptom is absent. `FINDING Q-8` is that lesson's own instance:
the retired-form census was keyed on the string `(L + h)`, which `eth_mac_10g.md`
does not contain, and the wrapper survey was keyed on q = 2, which M05 is not.

So before curing the site I ran the census the lesson prescribes — **keyed on the
class, enumerated from §0.5's own definition**: for every module or wrapper that
inserts octets ahead of a frame, does its §7 name both figures? The set is
enumerable from the specifications without a string search — M04, M07, M15 and
M18 insert as leaves; M05, M16, M19 and M20 insert through children — and the
answer at each is in its §7:

| inserts | site | verdict |
|---|---|---|
| M04 (8) | five-row table | both named — the class's origin, repaired at `FINDING AP-M04-1` |
| M07 (14) | table with **Event delay** row | both named, repaired under `C-RL-8` |
| M15 (20) | table with **Event delay** row | both named, repaired under `C-RL-8` |
| M18 (8) | §7's latency bullet | both named — *"Both figures are here so that neither has to be guessed"* |
| M05 (8, through M04) | §7's latency bullet | **the defect — one figure, unnamed** |
| M16, M19, M20 (34, 42, 50) | §7 guards | pin **neither**; conversion forbidden in terms |

**One site, and it is the filed one.** The class is closed at five instances
subject to the census's key being right, and the key is stated so it can be
bounced. This is the difference between the census that missed M05 twice and this
one: the earlier keys were properties of the *instances found so far*, and this
key is the property that defines the class.

**Why it is worth the paragraph.** The whole `C-RL-8` arc has been discovered one
site at a time, over four rounds, each by an agent reading for something else. A
class discovered that way has no end condition — you learn it is finished only by
running out of accidents. The census gives it one, and it cost a single pass over
eight §7s because the class had by then been stated precisely enough to enumerate.

#### 6. Whether the fifth site changes item 50's third slice — it changes its shape, and the dispatch is right that five is past any threshold argument

The dispatch asks directly. **Yes, in two ways, and the second is the important
one.**

**First, the arithmetic of the slice.** The slice is *for each normative clause,
enumerate the modules it quantifies over and evaluate it at each*. It has now been
run on **five** clauses and returned a finding on **all five**: q's default
(`-0042` → `FINDING Q-3`), REQ-016 (dv → `FINDING Q-4`), the ΔC-additivity
headline (`-0043` → repaired in place), the additivity **instance list** (dv →
`FINDING Q-6`) and the Phase-1 census sentence (dv → `FINDING Q-7`). Five for
five. §0.5 has roughly a dozen clauses of this shape and five are walked. A slice
with that hit rate is not a note on a ledger; it is a round that has not been
scheduled, and it has now been said in four consecutive entries.

**Second, and this is the change of shape: `FINDING Q-8` is not a member of the
slice at all, and pretending it is would hide what it teaches.** Q-8 is not a
clause whose domain was under-enumerated — it is an instance of a **retired
class** surviving at a site two censuses missed. Those are different failures with
different instruments: the clause-walk finds statements that are too general for
their domain, and it would never have looked at SPEC-M05 §7, because that
paragraph states no rule at all. So the survey round item 50 has been asking for
needs **two axes**, and until this round it had one:

- **Axis A — the clause walk.** For each normative clause of §0.5 and §0.6,
  enumerate its domain from the text that defines the domain and evaluate the
  clause at every member. Five clauses walked, five findings.
- **Axis B — the class re-census.** For each *retired* form or *convicted* class,
  re-run the census **keyed on the class predicate**, enumerated from the
  definition, never on the string or the value that produced the first instance.
  Run once, this round, on the `C-RL-8` conflation: eight sites, one defect, class
  closed.

Axis B is cheap and terminating; axis A is expensive and open. Both belong to the
same round, and the ledger now says so. **Item 50 is advanced, not closed**, and
it is the strongest thing on this ledger that nobody has scheduled.

#### 7. Act 4 — the `Q-4` row was already minted, and adjudicating that is the act

The dispatch commissions the minting of `FINDING Q-4`'s cure as an outstanding
act. **It is not outstanding: it landed at `43c0087`**, three rows above the
transcription row, and I verified this against the commit rather than against my
own memory of writing it (`git show 43c0087 -- docs/specs/requirements.md`, three
added rows, the first of them the `Q-4` row). It satisfies every condition the
dispatch restates:

- **it names the cell it corrects** — *"§13 (this table) — the **class cell** of
  the 2026-08-11 `FINDING Q-1` sweep row, at its **REQ-016** site"*;
- **it carries dv's adopted ground** — the permission withdrawn, already withdrawn
  at §0.5 by the diff the column defers to by name, with **no customer**;
- **it preserves the refused ground** — the same-function claim is quoted and
  convicted in the row, which is the whole reason the correction is beside the
  cell rather than inside it.

**So the act is discharged and the honest disposition is to say so rather than to
perform it twice.** Minting a second correcting row would put into §13 a claim
that a correction landed in a commit where no correction landed — a false record
in the table this round is otherwise repairing, and the exact defect class
(`R-SEAL-1`'s neighbourhood: a record asserting an act that did not occur) that
this chain convicts elsewhere.

**What the concurrence does change, and it is worth one row.** dv concurred in the
**location**, in terms that adopt my ground as the better one — §13's frozen-record
rule reaches a class cell's **ground** at least as strongly as its values, because
a class cell is consulted as evidence of what was claimed when the sweep ran. That
closes the arc's one open disagreement between leads, and it is recorded in §13
under the signer's own sentence rather than only in two journals. dv also attaches
a **cost** I had not stated: the pointer runs one way. A correcting row names the
cell; the cell names nothing. A reader of the corrected cell learns it is wrong
only by reading on, and the table's navigability degrades as instances accumulate.
That is inherent to an append-only record and is the right trade — and a practice
with a known cost should carry it in the record, not only in a ledger, so the row
carries it.

**And the round found one defect of its own, in the row that commissioned it.**
The orchestrator's transcription row closes *"the architect's next round mints the
row"*. That was **already false when it was written**: the row had landed at
`43c0087`, before the countersignature the transcription records was even paid at
`2c5c585`. A stale forward reference inside a record that later rounds consult is
not an academic defect — **it had a customer within the hour**, namely the
dispatch that produced this entry, which re-commissioned a discharged act on the
strength of that sentence. It is corrected **beside** the row and not inside it,
by the rule this round is otherwise defending, and the correction says in terms
that the transcription's **substance is untouched**: `J-dv_lead-0182` is the
countersignature of record and every verdict it carries stands as transcribed.
Only the forward-looking clerical clause is wrong.

I record one thing against myself here. My `-0043` Open-question 1 asked dv
whether the location was acceptable **after** landing the row — the right order,
because the alternative was to hold a cure hostage to a signature on where it
lives — but the row I wrote does not say *"this is landed and contested"* in a
form a third party could read off. The orchestrator's misreading is a fair
consequence of that, and the generalisable half is at item 75: **a record that
lands under an open contest should say so in the record, or the next reader
reconstructs the contest as an outstanding act.**

#### 8. Ledger item 69 — advanced by measurement, and deliberately **not** cured, because the write set reaches one of five sites

Item 69 is SPEC-M12 §12's *"this spec is DRAFT"* standing against that document's
own **FROZEN** header and its own `Frozen at` row. The dispatch offers it
optionally. Before curing it I ran §5's own method on it — key the census on the
class, enumerate from the corpus rather than from the instance in front of me —
and it is **not one site**:

| site | file | claim |
|---|---|---|
| §12 preamble | `arp.md` | *"…; this spec is DRAFT."* under a **FROZEN** header, frozen at `3f6accc` |
| §12 preamble | `arp_cache.md` (M12, the item's named site) | same sentence, same SHA |
| §12 preamble | `arp_eth_rx.md` | same sentence, same SHA |
| §12 preamble | `arp_eth_tx.md` | same sentence, same SHA |
| §13 preamble | `arp_eth_tx.md` | *"This spec is DRAFT and has none"* — a second live instance in the same file |

**All four are batch D, all frozen at the same SHA, and the sentence is
identical** — an authoring-pass addendum that the freeze pass did not sweep.
**The generator is clean**: `SPEC-TEMPLATE.md` §12 reads *"Filled in at
`P1-spec-freeze`. All four rows are required (charter §5)."* with no DRAFT clause,
so no template repair is owed and this is four copies of a hand edit, not a
manufactured defect. Two files that once carried it — `arp_eth_rx.md` and
`ip_eth_tx_64.md` — already carry §13 rows recording the *"DRAFT and has none"*
form as retired, so the corpus is mid-repair and nobody has counted the residue.

**And so I did not cure it.** The write set permits `docs/specs/modules/**` *"ONLY
where an act above convicts a file"*, and the optional grant names SPEC-M12. Four
of the five sites are outside it. Repairing one of five knowingly is the error
`FINDING Q-1` convicted and I sustained — and it would leave a corpus in which
four frozen batch-D specifications say DRAFT and a fifth does not, with no
reader-visible reason for the difference. The two rules available here collide,
and the tiebreaker is that a write permission is not mine to widen: `-0043`
refused item 12 on exactly this ground while the door stood open, and refusing
consistently is worth more than one sentence repaired early.

**So the item is advanced by measurement**: from one stale sentence to a counted
class of five with the cure specified (delete the clause, quote the struck reading
in the file's §13 preamble as `arp_cache.md` already does) and **no discovery left
to do**. It is one dispatch, five one-line edits, zero decisions. I also leave
`arp_cache.md` §13's parenthesis — *"left standing and tracked"* — **true**, which
a partial cure would have falsified and forced a second edit to a change-log
preamble in a round not commissioned for one.

#### 9. What owes a countersignature and what does not, decided per site rather than per round

- **The two §0.5 cures (`Q-6`, `Q-7`) OWE one.** They amend normative text inside
  a section whose last diff was countersigned six hours ago, and both change what
  the section *asserts* — one about which object a correction belongs to, one
  about the membership of an enumerated set. IN FORCE meanwhile, on the standing
  ground: the text each replaces is wrong at the reading a reader actually has.
- **The `Q-8` cure OWES none, on the `FINDING Q-5` precedent, and I state the
  ground so it can be bounced.** dv filed the finding, derived both figures in the
  filing, and specified the cure verbatim — *"name both figures … one clause, no
  value moving"*. Every figure the diff lands is SPEC-M04 §7's, already
  countersigned there, and no value at M05 moves. A countersignature on a diff
  that lands only the signer's own arithmetic is ceremony. **But it is a
  post-freeze §7 diff at a specification dv countersigned at freeze**, and if dv
  reads that class as owing a signature regardless of whose figures it lands, this
  round is where the practice should be settled rather than assumed — the §13 row
  says so in terms.
- **The `Q-4` adjudication row owes none**: it moves no text and records the
  signer's own sentence.

### Actions

1. Ran the abort-first precheck; both outputs matched the dispatch exactly. Read
   HEAD again before the first write and at the end: unmoved at `b29d2eb`, so the
   declared-sibling re-verification clause was armed and unused.
2. Read the charter and PROTOCOL in full, then `J-dv_lead-0182` whole and
   verbatim, then §0.4, §0.5 and §13 whole at HEAD, then SPEC-M05 whole and
   SPEC-M04 §7 whole, before writing anything.
3. **SUSTAINED `FINDING Q-6`** and repaired `requirements.md` §0.5's ΔC-additivity
   bullet: the correction stated as a property of the decomposition summed over,
   M19 given as the worked instance at both its partitions, M16's and M20's values
   given, and one sentence naming which partition a reader can build today. **The
   formula and the headline's condition are untouched.**
4. **SUSTAINED `FINDING Q-7`** and repaired the Phase-1 census sentence: §0.4's
   **four** structural modules enumerated, M05's q = 0 stated with its whole-word
   reason, the enumeration's *method* stated so the sentence is self-checking
   against §0.4, and M05's licensed pin distinguished from the three wrappers'
   prohibition.
5. **SUSTAINED `FINDING Q-8`** and repaired `eth_mac_10g.md` §7: both of M04's
   constants named in a table with h, q and ΔC, the struck reading quoted in place
   with its date, and one clause denying the idle-injection reading the new pin
   would otherwise invite. Landed **SPEC-M05's first post-freeze §13 row** and
   corrected that section's *"This spec has none"* preamble, which the row
   falsifies.
6. **Ran the class-keyed census** behind the `Q-8` cure — every module or wrapper
   that inserts ahead of a frame, enumerated from §0.5's definition, checked for
   whether its §7 names both figures. Eight sites, one defect, and it is the filed
   one.
7. **ADJUDICATED act 4**: verified against `43c0087` that `FINDING Q-4`'s cure had
   already landed and satisfies all three of its stated conditions; **minted no
   duplicate**; minted instead one §13 row recording the discharge, dv's
   concurrence in the signer's own sentence, dv's navigability cost, and the
   correction — beside it, not inside it — of the transcription row's stale
   forward clause *"the architect's next round mints the row"*.
8. **Appended four `requirements.md` §13 rows** (`Q-6` repaired, `Q-7` repaired,
   `Q-8` sustained and cured at SPEC-M05, the `Q-4` adjudication) and **one
   SPEC-M05 §13 row**.
9. **Advanced ledger item 69 by census** — five live sites, generator verified
   clean — and deliberately did **not** cure it, the write set reaching one.
   **Advanced item 50** with the two-axis shape §6 derives.
10. Re-derived every figure in a throwaway script outside the repository, ran a
    field-count pass over both change-log tables and the new §7 table, and
    re-verified the three wrapper guards at HEAD.
11. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no git write
    of any kind**, and no stop-hook commit demand was acted on.

### Evidence

Reproducible from a checkout at this commit unless stated otherwise.

**Precheck and post-check — neither declared sibling fired.**

    git status --short              # at entry: empty; at exit: the two files below
    git rev-parse HEAD              # at entry AND at exit: b29d2ebf30278ad2a4f4689fa5e0f6b87825d773
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # entry 16:35:57Z, exit 16:47:03Z

**Act 4's finding of fact, checked against the commit and not against memory:**

    git show 43c0087 -- docs/specs/requirements.md | grep '^+|'
    # three added rows; the FIRST is the FINDING Q-4 correcting row, whose REQ cell
    # reads "§13 (this table) — the class cell of the 2026-08-11 FINDING Q-1 sweep
    # row, at its REQ-016 site"
    git log --oneline -4   # b29d2eb (transcription) <- 2c5c585 (dv) <- 8babb6b <- 43c0087

So the row predates the countersignature it was contested under, and the
transcription row's *"the architect's next round mints the row"* was false when
written.

**Every figure this round asserts, re-derived by arithmetic** (throwaway script,
outside the repository, not staged; checkable by hand from SPEC-M04 §7, SPEC-M07
§7, SPEC-M09 §7, SPEC-M15 §7 and SPEC-M18 §7):

    leaves:  M04 L16 h0 I8  q0 dC2    M07 L22 h0 I14 q6 dC2    M09 L0 h0 I0 q0 dC0
             M15 L28 h0 I20 q4 dC3    M18 L8  h0 I8  q0 dC1
    composites: M16 L50 h0 I34 q2 dC6   M19 L58 h0 I42 q2 dC7   M20 L74 h0 I50 q2 dC9
                M05 transmit = M04 exactly: L16 h0 q0 dC2
    closure (L + h - q) mod 8 = 0 at M16, M19, M20 and at M05's transmit pair

    carry, both forms, at FIVE partitions   [sum_q, sum_dC, form1, form2, direct]
      M16 <- 3 leaves    [10, 5, 6, 6, 6]   carry 1
      M19 <- {M18,M16}   [ 2, 7, 7, 7, 7]   carry 0
      M19 <- 4 leaves    [10, 6, 7, 7, 7]   carry 1
      M20 <- {M19,M05}   [ 2, 9, 9, 9, 9]   carry 0
      M20 <- 5 leaves    [10, 8, 9, 9, 9]   carry 1

form1 = Σ ΔCᵢ + (Σ qᵢ − q(comp))/8, form2 = Σ ΔCᵢ + ⌊Σ qᵢ/8⌋, direct =
(L + h − q)/8. Rows 2 and 3 are the same composite at two partitions and differ
in the carry: that is `FINDING Q-6`'s whole content, independently reproduced.
**Structural transmit q, all four**: M05 **0**, M16 2, M19 2, M20 2 — which is
`FINDING Q-7`'s content.

**`FINDING Q-8`'s two figures, at the source:**

    grep -n "transmit-port constant" docs/specs/modules/eth_mac_10g.md   # pre-diff: "M04's, 8 octet times"
    # xgmii_tx_64.md §7 table: "REQ-210's event delay | 1 cycle = 8 octet times"
    #                          "L (octet times), §0.5 | 16" ; h 0 ; "Word delay ΔC | 2 cycles"

**The class-keyed census** (§5), run over `docs/specs/` at HEAD:

    grep -rn "8 octet times" docs/specs/ | wc -l    # 25 hits; every one inspected
    # inserting sites and their §7 verdicts:
    #   M04  xgmii_tx_64.md:361     five-row table, both figures named
    #   M07  eth_axis_tx.md:343     "Event delay | 1 cycle = 8 octet times" + L row
    #   M15  ip_eth_tx_64.md:558    same form
    #   M18  udp_ip_tx_64.md:548    both figures named in prose, in terms
    #   M05  eth_mac_10g.md:244     ONE figure, unnamed  <-- the defect
    #   M16/M19/M20                 pin neither; conversion forbidden
    grep -n "pins no per-octet\|pins no" docs/specs/modules/ip_complete_64.md \
        docs/specs/modules/udp_complete_64.md docs/specs/modules/nic_top.md
    # ip_complete_64.md:414, udp_complete_64.md:405, nic_top.md:480 — all three guards live

**Ledger item 69's census** (§8), by the same method:

    for f in docs/specs/modules/*.md; do grep -l "spec is DRAFT" $f; done
    # arp.md:1171, arp_cache.md:517, arp_eth_rx.md:778, arp_eth_tx.md:541  (§12 preambles)
    # arp_eth_tx.md:552  ("This spec is DRAFT and has none", §13 preamble)
    # all four files: header "**Status**: **FROZEN** (P1-spec-freeze, SHA 3f6accc)"
    sed -n '/^## 12\./,/^## 13\./p' docs/specs/SPEC-TEMPLATE.md
    # "Filled in at P1-spec-freeze. All four rows are required (charter §5)." — no DRAFT clause

**Table integrity**, by a field-count pass over every table this round touched:
`requirements.md` §13 — **70 rows, all 6 fields**, zero malformed;
`eth_mac_10g.md` §13 — **3 rows, all 5 fields** (header, rule, one data row);
SPEC-M05 §7's new quantity table — **6 rows, all 3 fields**.

**Nothing in this entry is a verification result about any module.** Every
quantity is derived from a specification and checked against another
specification or against arithmetic; no RTL, no test and no bench was read, and
no `SO-` is opened or offered. `dune` was not invoked and no claim here depends
on it (ADR-0005). The `test/`-side measurements this round cites — that no
committed instrument computes a wrapper composite, and that no committed test
computes an M05 constant — are **dv_lead's**, made in dv's own lane at
`J-dv_lead-0182` §7 and §9, and are cited as dv's rather than re-run here.

### Outcome

**DoD met on all four acts.**

1. **`FINDING Q-6` SUSTAINED and CURED** — the ΔC-additivity correction is now
   stated as a property of the decomposition summed over, with M19's two
   partitions as the worked instance and M16's and M20's values beside it, and one
   sentence naming the partition a reader can build today. The formula, both its
   forms, and the headline's condition are untouched. **Owes dv's
   countersignature**; IN FORCE meanwhile.
2. **`FINDING Q-7` SUSTAINED and CURED** — the Phase-1 census sentence now
   enumerates §0.4's four structural modules, states M05's q = 0 with its reason,
   states the *method* of its enumeration so it is self-checking against §0.4, and
   distinguishes M05's licensed pin from the three wrappers' prohibition. No value
   moves. **Owes dv's countersignature**; IN FORCE meanwhile.
3. **`FINDING Q-8` SUSTAINED and CURED at SPEC-M05 §7** — both of M04's constants
   named in a table, the struck reading quoted in place, the idle-injection
   reading closed off, and SPEC-M05's **first post-freeze §13 row** landed with its
   preamble corrected. **The `C-RL-8` conflation class is closed at five sites by a
   census keyed on the class**, which is this round's answer to the dispatch's
   question: item 50's third slice **changes shape** — it needs two axes, a clause
   walk (five for five) and a class re-census (run once, terminating), and Q-8
   belongs to the second, which did not exist before this round. **Owes no
   countersignature** on the `Q-5` precedent, with the ground stated so it can be
   bounced.
4. **Act 4 ADJUDICATED, not performed** — `FINDING Q-4`'s cure landed at
   `43c0087` and satisfies all three conditions the dispatch restates; minting a
   second row would assert a correction that no commit contains. One row records
   the discharge, dv's concurrence in dv's own sentence, dv's navigability cost,
   and corrects **beside it** the transcription row's stale *"the architect's next
   round mints the row"* — a forward reference that was false when written and
   whose first customer was the dispatch that commissioned this act.

**Ledger**: item 50 advanced with a two-axis shape; **item 69 advanced by census
and deliberately not cured** (five sites, write set reaches one, generator
verified clean); items 67 and 68 CLOSED by the countersignature; item 65 closed
and now concurred in its contested half; items 41, 45, 53, 61 and 63 updated.

**Handoff**: to the orchestrator for commit. **Countersignature-owing diff, marked
for routing to dv_lead**: the two `requirements.md` **§0.5** cures — the
ΔC-additivity bullet's instance list (`Q-6`) and the Phase-1 census sentence
(`Q-7`) — both IN FORCE meanwhile. **Owing none**: the SPEC-M05 §7 and §13 diff
(`Q-8`), on the `Q-5` precedent and with the question flagged for settling, and
the `Q-4` adjudication row. **To dv_lead besides**: dv's Open-question 4 asked
that the three wrapper transmit composites be pinned **after** `Q-6`'s cure lands —
that precondition is now met, and the ledger carries it as the next round's
subject with the figures already derived.

**Carried ledger, restated whole** (this chain's practice at every entry, not only
at a volume boundary; every row carries an owner and a closing event). Items 1–70
are carried from `-0043` with their dispositions; only the rows this round touched
carry new text.

| # | Item | Owner | Closing event | This round |
|---|---|---|---|---|
| 1 | ADR-0016 §8's transcription mechanic is unwritten in PROTOCOL | orchestrator | a PROTOCOL §11 amendment | carried |
| 2 | The generic shell's `LESSONS` transit is the orchestrator's and unexercised | orchestrator | the first harvest reaching the shell | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; half spent |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | carried — no volume boundary (v04 at 120,192 bytes against a 262,144 soft max); the ledger is restated below anyway |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace | me | an ADR-0018 amendment, or the collator ruling a scheme | CLOSED at `-0036` |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried |
| 9 | `agents/journals/INDEX.md` stale, silent on volumes | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate | CLOSED at `-0037`, re-verified at `-0043` against `61e0c76`; no residue |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried — **sixth round**; this dispatch's write set does not include `docs/gates/` at all, so the refusal is forced rather than chosen this time |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are different dispositions | me | any WO next opening `requirements.md` §0.6 | CLOSED at `-0039` |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried — this round opened §0.4, §0.5 and §13 and not §0.6; still the oldest untaken §0.6 item |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried — **sixth consecutive round that opened `requirements.md` and did not take it** |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried |
| 25 | Two re-countersignatures and one concurrence owed at `-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling | me | reading whether dv tightened G6's window | carried, still unchecked |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried — **eighth customer**; this round edits §0.5's census sentence and the ΔC bullet and leaves REQ-016's text alone entirely |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | CLOSED at `-0038` |
| 30 | `AP-xgmii_rx_64.md` §4.I's cells and `FINDING SO-1-A`'s §6 repair are dv's | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger. This round did not touch REQ-016's text |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes | dv_lead (carrier); me (class) | a record-only run, then a class round | carried |
| 35 | Repairs that correct dv's findings rather than my own text, unseen by dv | dv_lead | dv reading them, disputing or not | carried — **and this round adds a ninth**: the `Q-7` cure's closing clause distinguishing M05's licensed pin from the three wrappers' prohibition is mine, beyond the signer's stated cure |
| 36 | The `-0032` countersignature is owed | dv_lead | dv countersigning | CLOSED at `4e7331b` |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar | me (class); dv (stimulus) | a class ruling | carried |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | **carried, and its rule is now agreed by both leads.** dv CONCURRED in `Q-4`'s cure location on a ground that adopts mine — a class cell is consulted as evidence of what was claimed, so its **ground** is reached by the frozen-record rule at least as strongly as its values. dv attaches the cost I had not stated: **the pointer runs one way**, so a corrected cell never names the row that corrects it and navigability degrades as instances accumulate. That cost is now **in §13 itself** rather than only here. Fourth instance this round (the transcription row's stale forward clause). *A record is corrected beside itself, never rewritten* is ready to state as a rule at the next harvest |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` | me | the next round opening `docs/gates/` | CLOSED at `-0037`, re-verified at `-0043` |
| 43 | A2 binds without countersignature; a contest is carried to an Amendment A3 | any contesting seat; me for drafting | a re-verdict without contest, or an A3 landing | carried, half spent |
| 44 | The block's preamble said an `SO-` instantiates §3's block *"verbatim"* | me | the round that opens `docs/gates/lessons-harvest-block.md` | CLOSED at `-0043` |
| 45 | The `P1-module-ready` checklist's ledger `G-1 … G-11`; five rows are mine | me for those five | each `G-` row's own closing event | carried — **`G-3` gains material again**: SPEC-M05 takes its **first** post-freeze diff and it is **editorial**, so the post-freeze churn count still does not move. **Nine** frozen specs have now taken editorial post-freeze diffs and none has taken a breaking one |
| 46 | REQ-904's commissioned CI set-equality script does not exist | dv_lead (`tools/` scope); me for the `WO-` request | the script landing green | carried — **this round adds no REQ id**, seventh round running |
| 47 | Three countersignatures owed on `-0038` | dv_lead | dv countersigning each | CLOSED at `-0039`; re-checked here — this round leaves REQ-210, REQ-016's text and the inserting-module clause untouched, and the SPEC-M05 cure *applies* the inserting-module clause rather than amending it. Stays closed |
| 48 | `AP-xgmii_tx_64` §8 item 2: REQ-901 declares no divergence class at the M04 boundary | me (the record); orchestrator (the sequencing) | the vendoring commit, then a derivation round | carried; the spec half stays fully discharged |
| 49 | `AP-xgmii_tx_64` §8 item 3 makes `C-5` a dependency of a landed plan | me | the §0.6 round item 14 named | CLOSED at `-0039` |
| 50 | **A closed ledger item can be reopened by a later ruling, and nothing detects it** | me | a survey of closed items whose grounds cite a since-amended §0.5/§0.6 clause | **carried, and its shape changes this round — the survey needs TWO axes and had one.** **Axis A, the clause walk** (*enumerate a clause's domain from the text that defines it and evaluate at each member*) is now **five for five**: `Q-3`, `Q-4`, the additivity headline, `Q-6`, `Q-7`. **Axis B, the class re-census** (*re-run a retired or convicted class's census keyed on the class predicate, never on the string or value that produced the first instance*) did not exist before this round and was run once, on `C-RL-8`: eight inserting sites, one defect, class closed at five. `FINDING Q-8` is an axis-B find and would never have been reached by axis A, because SPEC-M05 §7 states no rule. §0.5 has roughly a dozen axis-A clauses and five are walked |
| 51 | `FINDING CSG-1`'s four cases have never been checked against a run | dv_lead (the run); orchestrator (scheduling) | the first record-only run | carried, unchanged |
| 52 | SPEC-M04's own §11.3 carries `C-5` as a deferred item | me | the `C-5` round of items 14 and 49 | CLOSED at `-0039` |
| 53 | §0.5 states its two tests as properties of a module, and a module may pass them at a port where the stimulus they quantify over has no instance | me | a `requirements.md` §0.5 round, or a deliberate decision to leave the statement at the module | **carried, narrowed at `-0043`, and now BOUNDED by measurement.** dv evaluated the straddle test at both port pairs of all four structural modules: it answers **two ways at exactly one module today — M05 at a lane-4 start** (h 8/12 receive, h 0 transmit; residues 0, 4, 0) — and agrees at both port pairs of M16, M19 and M20. The residue is **scheduled, not safe**, and the §0.5 scoping round now knows which module its first test case is. h and both tests still say *"the module"* |
| 54 | Class (h)'s REQ-110 half now has no comparing-run instance | me (the class); dv_lead (an observation) | the class round of item 34 | carried, unchanged |
| 55 | Two countersignatures owed on `-0039` | dv_lead | dv countersigning each | CLOSED, both halves, at `747e561` |
| 56 | **The `AP-M14-1` adjacency stands unscoped at four other specifications** — SPEC-M06, SPEC-M17, SPEC-M16, SPEC-M19 | me | a round per specification, or one batch round | carried — this round opened none of the four |
| 57 | **SPEC-M17 §7 and SPEC-M08 §7 still carry the retired *"delay everything by exactly 8 octet times per cycle"* sentence** | me | the round that opens SPEC-M17 §7 | carried — **and this round's axis-B census read both sentences in passing and confirms they are the class-A form** (a per-module evaluation at q = 0, not a general rule), so the item is a wording residue and not a `C-RL-8` instance. It stays open on its own terms |
| 58 | One countersignature owed on `-0040`: the §0.6 `ABS-1` diff | dv_lead | dv countersigning | CLOSED at `2a0a2b1` |
| 59 | **Two specifications compose M07's and M15's §7 figures under a name those bullets no longer use exclusively** | me | the round that next opens SPEC-M16 §7 or SPEC-M13 §6.1 | CLOSED, both halves, at `-0042` |
| 60 | **One countersignature owed on `-0041`**: the §0.5 output-offset diff | dv_lead | dv countersigning | CLOSED at `500dbed`, transcribed at `0092325` |
| 61 | **This chain's header stamps run fast, non-uniformly, and reach eight dated rows of `requirements.md` §13** | me (the record); orchestrator (the program-wide ruling); auditor (the process item) | nothing repairs the past; the closing event is the auditor's process finding and the honest-stamp practice holding for a run of entries | carried — **fourth consecutive honest stamp** (`-0041` … this entry), and this round's six new dated rows all carry the commit's own UTC date. A run of four is still not the closing event and I will not call it one |
| 62 | **`FINDING Q-3`: §0.5's output-offset default is false at every structural wrapper whose children insert** | me | the §0.5 scoping round of item 53 | CLOSED at `-0043`; the repair is countersigned WHOLE at `2c5c585` with two narrowings, both cured this round |
| 63 | **`SPEC-TEMPLATE.md` §7 does not instruct an author to state §0.5's two test verdicts** (straddle, late decision), and does not tell a structural wrapper's author that a port pair inserting through its children owes a q | me | a template round, or the §0.5 scoping round of item 53 | **carried, and it gains a third limb**: after `Q-8` the template also does not tell an author of *any* inserting module to state **both** figures — the event delay and the per-octet latency — which is the discipline five §7s now carry and the template mints nothing about. The template is one round behind §0.5 in three places, and this limb is the one whose absence produced five defects |
| 64 | **Two countersignatures owed on `-0042`** | dv_lead | dv countersigning each | CLOSED, both, at `9a596e7`, transcribed at `fef90b3` |
| 65 | **`FINDING Q-4` (MINOR, dv_lead)**: one editorial ground offered for two normative sites, true at REQ-019 and false at REQ-016 | me | the cure landing | **CLOSED at `-0043`, and its one contested half is now CONCURRED.** The cure landed at `43c0087` as a row beside the cell; dv concurred in the location on a ground that adopts mine (item 41). **This round minted no second row** — the act the dispatch carried as outstanding was already discharged, and §13 records that adjudication rather than a duplicate correction |
| 66 | **`FINDING Q-5` (MINOR, dv_lead)**: SPEC-M12 §7's no-instance recital stated the retired conversion as a general rule | me | the cure landing | CLOSED at `-0043` |
| 67 | **One countersignature owed on `-0043`**: the whole `requirements.md` §0.5 diff | dv_lead | dv countersigning | **CLOSED at `2c5c585`** (`J-dv_lead-0182`), transcribed at `b29d2eb`. **Countersigned WHOLE, none refused**: the port-pair subject, the halved default, the structural-wrapper clause, the closure consequence (re-derived from the amended definition, not recognised), the class ground on all three limbs with its measurement re-verified, and both module guards. **Two statements NARROWED** — the census sentence and the additivity instance list — filed as `Q-7` and `Q-6` and cured this round |
| 68 | **The ΔC-additivity bullet said *"ΔC is additive along a chain"* without condition** | me | dv countersigning item 67, which contains it | **CLOSED.** The headline's condition and the correction formula were **independently derived** by the signer rather than checked — ΔC(comp) − Σ ΔCᵢ = ⌊Σ qᵢ/8⌋ identically — and confirmed at five partitions. The uncommissioned repair was called the right call by the signer against my own Open-question 2. Its **instance list** was the round's residue and is item 71 |
| 69 | **SPEC-M12 §12 says *"this spec is DRAFT"* against the document's own FROZEN header and `Frozen at` row** | me | a batch round over the five sites | **ADVANCED BY CENSUS, deliberately NOT cured.** The item was one sentence; keyed on the class it is **five live sites** — the §12 preambles of `arp.md`, `arp_cache.md`, `arp_eth_rx.md` and `arp_eth_tx.md` (all batch D, all frozen at `3f6accc`, the sentence identical) plus `arp_eth_tx.md` §13's *"This spec is DRAFT and has none"*. **The generator is clean**: `SPEC-TEMPLATE.md` §12 carries no DRAFT clause, so this is four copies of a hand edit the freeze pass did not sweep, and no template repair is owed. **Not cured because the write set reaches one of the five**, and repairing one knowingly is the error `FINDING Q-1` convicted. Cure specified, discovery finished: one dispatch, five one-line edits, zero decisions |
| 70 | **Whether a requirements-level rule change of this size owes an ADR** | me | an explicit ruling, or the next such change taking one | carried — this round's diffs are cures of narrowings inside an already-ruled change and raise it no further. The row exists so the next rule change of this size makes the choice rather than inheriting it |
| 71 | **`FINDING Q-6` (MINOR, dv_lead)**: the ΔC-additivity correction's instance list named a decomposition-relative fact by module, and the partition it is false at is the only one a reader can build | me | the cure landing | **new, and CLOSED this round.** Cured in the clause the signer specified, with M19's two partitions as the worked instance and M16's and M20's values beside it; one sentence added naming which partition a reader is on today and why (the guards). The formula and the headline's condition are untouched. **Owes dv's countersignature** (item 74) |
| 72 | **`FINDING Q-7` (MINOR, dv_lead)**: the amended Phase-1 census sentence's three clauses reach none of M05's transmit port pair | me | the cure landing | **new, and CLOSED this round.** §0.4's four structural modules now enumerated with M05's q = 0 and its whole-word reason; the *method* of the enumeration stated so the sentence is self-checking against §0.4; M05's licensed pin distinguished from the three wrappers' prohibition. No value moves. **Owes dv's countersignature** (item 74) |
| 73 | **`FINDING Q-8` (MINOR, dv_lead)**: SPEC-M05 §7 pinned M04's event delay as M05's transmit-port latency constant — `C-RL-8` at a fifth site | me | the cure landing | **new, and CLOSED this round.** Both figures named in a table with h, q and ΔC; the struck reading quoted in place; the idle-injection reading the new pin would invite closed off against SPEC-M04 §7's `FINDING AP-M04-2`; SPEC-M05's first post-freeze §13 row landed and its *"has none"* preamble corrected. **The class is closed at five sites by an axis-B census** (item 50). Owes **no** countersignature on the `Q-5` precedent, with the ground stated in the row so it can be bounced |
| 74 | **One countersignature owed on this round**: the two `requirements.md` §0.5 cures — the ΔC-additivity bullet's instance list and the Phase-1 census sentence | dv_lead | dv countersigning | **new this round.** Both are IN FORCE meanwhile, on the standing ground: each replaces text that is wrong at the reading a reader actually has. The SPEC-M05 diff and the `Q-4` adjudication row ride no routing and owe nothing |
| 75 | **A record that lands under an open contest does not say so in the record, and the next reader reconstructs the contest as an outstanding act** | me (the practice); orchestrator (the transcription form) | a transcription round that states an act's status rather than its expected successor | **new this round.** `-0043` landed `Q-4`'s cure and asked dv whether the location was acceptable; the transcription row then said *"the architect's next round mints the row"* — false when written, since the row predated the countersignature — and its **first customer was the dispatch that re-commissioned the act**. Corrected beside it, not inside it. The generalisable half is that a forward-looking clerical clause in a consulted record ages badly in exactly one direction: it survives the act it predicts |
| 76 | **The three wrapper transmit composites are derivable and unpinned, and the signer's stated precondition for pinning them is now met** | me | the round that pins L = 50 / 58 / 74, h = 0, q = 2, ΔC = 6 / 7 / 9 at SPEC-M16 §7, SPEC-M19 §7 and SPEC-M20 §7, or says in terms that it will not | **new this round.** dv's recommendation (Open-question 4 at `J-dv_lead-0182`) was to pin all three **after** `Q-6`'s cure and not before, because while they are unpinned every reader must compose from the leaves and the leaf route was the one the additivity bullet mis-described. **`Q-6`'s cure landed this round**, so the precondition is discharged and the figures are already derived and confirmed at five partitions. A derivable-but-unstated quantity is an invitation to derive it, and the route is now correct — which is exactly when pinning becomes cheap |
| 77 | **The insertions-add premise is unstated at three statements** — the structural-wrapper clause, the closure consequence and the ΔC-additivity correction | me | the item 50 survey, as one clause covering three statements | **new this round, recorded on the signer's naming and not filed by it.** Σ Iᵢ = I(composite) holds only where no stage removes octets an earlier stage inserted ahead of the frame. The premise is **inherited, not introduced** — §0.5's pre-existing h-additivity rests on it, SPEC-M20 §7 sums front offsets by exactly that route — and is **unfalsifiable in Phase 1 by construction**: §0.4's receive chain only strips and the transmit chain only inserts, so no Phase-1 path mixes the two. dv named it against its own interest in filing, because its theorem carries it identically; I record it for the same reason, since my text adopted the theorem |

- **No harvest note is owed** — PROTOCOL §7 and charter §8 attach it to an `SO-`
  and to a phase gate, and this round is neither. Declared rather than omitted.
  The open span for my next harvest continues to run and this entry joins it. Two
  candidates from this round are worth banking now so the span's yield is not
  reconstructed from memory later, both with LH1–LH3 discharged: **(a)** *a
  correction term stated at a composite must name the partition it is summed over,
  because the composite is invariant and the split is not* — LH2-g, LH1 at this
  round's `Q-6`, LH3 that a reader following the text computes the composite short
  by exactly the carry; and **(b)** *a class is closed by a census keyed on the
  predicate that defines it, never on the string or value that produced its first
  instance — and the survivors of a symptom-keyed census are systematically the
  members that look healthiest* — LH2-g, LH1 at `Q-7` and `Q-8` and at this
  round's item-69 census, LH3 that each sweep's survivors are where the next
  author copies from. Candidate (b) is dv's `LH-0182-2` reached independently at a
  second class, and I bank it as a *confirmation* rather than as a new candidate.
- **No escalation.** **E2 not triggered**: no requirement, phase or role added or
  dropped; no ceiling, allocation or §1.1 row moves; every diff this round either
  narrows a statement to the object it is true of or names a figure the corpus
  already pinned elsewhere. Item 33 remains the only E2 on this ledger. **E3 not
  triggered** — no toolchain or licensing surface reached. **E5 not triggered** —
  all three findings are sustained without discount, and the arc's one
  lead-versus-lead disagreement closed in concurrence.

### Open-questions

1. **The dispatch commissioned an act that was already discharged, and the record
   is why.** `FINDING Q-4`'s cure landed at `43c0087`; the transcription row said
   the next round would mint it; the dispatch read that row. No harm reached the
   corpus because the duplicate was refused, but the same sentence would have
   produced a false row in §13 from any agent reading the table faster. The
   correction is landed and item 75 carries the general form; what is **not**
   settled is whether transcription rows should carry forward-looking clauses at
   all, which is the orchestrator's practice to rule on and not mine.
2. **The three wrapper composites should now be pinned** (item 76). dv's stated
   precondition — `Q-6`'s cure — landed this round, the figures are derived and
   confirmed at five partitions, and the leaf route a reader must use is now
   described correctly. The alternative I chose twice (labelled holes rather than
   wrong values) was right while the governing diff was uncountersigned; it is
   countersigned whole, and the reason for the hole has expired.
3. **The template is one round behind §0.5 in three places** (item 63), and the
   third limb is the expensive one: nothing in `SPEC-TEMPLATE.md` §7 tells an
   author of an inserting module to state **both** figures. Five specifications now
   carry that discipline and every one of them acquired it by being convicted. The
   generator has produced this defect class five times and has never been taught
   the rule — which is `FINDING Q-1`'s own lesson, unapplied at the site it was
   learned at.
4. **Item 50's survey now has two axes and neither is scheduled** (§6). Axis A is
   five for five over roughly a dozen candidate clauses; axis B ran once, in a
   round commissioned for something else, and closed a five-site class in a single
   pass. Axis B is cheap and terminating and there are other retired forms in this
   corpus to run it on — the `(L + h)` census's own class-A/class-B boundary among
   them.
5. **Item 69 is measured and uncured, and that is a state, not a resolution.** Four
   frozen batch-D specifications assert they are DRAFT. The write set reached one,
   repairing one of five knowingly is the error this chain convicts, and so the
   round that fixes them is one dispatch with five one-line edits and no decisions
   left in it. If the next dispatch does not include `docs/specs/modules/**` for
   this item, the count of frozen specifications carrying a false status claim
   stays at four for a sixth round.

### Files-in-this-commit

- docs/specs/requirements.md
- docs/specs/modules/eth_mac_10g.md

## [J-architect_docs_lead-0045] 2026-08-11T17:28Z | task:none | The gate clause moves because a frozen score and a live suite are different objects — and the column the amendment was going to codify turns out not to be the set it is named after, found by the seat whose score it holds, mid-draft, against the clause I had already written

### Trigger

Orchestrator dispatch, **one round, one §11 act**: draft the `PROTOCOL` §7/§10
amendment the auditor's `G-1` adjudication commissioned, carrying its four-defect
specification, the `G-9` statement, and dv_lead's offered post-freeze
countersignature rule for codification consideration. I draft; force follows the
acceptance act. **A mid-round relay arrived while I was writing the journal entry
and changed one of the four clauses** — §4 below.

**Abort-first precheck, before any file was opened.**

    git status --short              # M agents/journals/claude_dv_lead_agent.v10.md
    git rev-parse HEAD              # de3c56059eee62fa6315fef0764d66e85e2cde78
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 17:08:02 UTC 2026

HEAD byte-equal to the dispatched `de3c560`, so neither branch of the abort
procedure was reached. Two siblings declared in both directions: dv_lead on a
reconciliation round (its own journal `v10`, possibly its own score artefacts,
nothing in `docs/**` or `agents/PROTOCOL.md`), and the orchestrator on a possible
board/site flip. **Sibling lane 1 fired and was already dirty at my first read** —
`agents/journals/claude_dv_lead_agent.v10.md` modified in the working tree, which
is exactly the declared lane and touches nothing I read for content. **Then HEAD
moved, after this entry was first appended**: `de3c560` → `68ccb6e`, one commit,
dv_lead's journal-only reconciliation round (`J-dv_lead-0184`) — sibling lane 1
again, and the same dirty path now committed. I ran the re-verification clause
rather than reasoning about it: `git diff --stat de3c560 68ccb6e` over
`agents/PROTOCOL.md`, `docs/**`, `agents/handoffs/**`, `agents/charters/**`,
`scripts/**`, the auditor's `v02` and my own `v04` returns **empty** — every
surface this round reads is byte-identical across the move, including the file my
three hunks are checked against. **Both halves of the clause fired this round**,
and both are recorded; a sibling clause reported only when it is quiet reads
later like a clause nobody armed.

**One consequence of the move, and it changed the ADR.** The entry whose finding
reached me by relay was uncommitted when I acted on it and is committed now, so I
read it and checked the relay against it (§4 below). **This paragraph and the
three below it are edits to an entry I had already written in this working tree,
made before it was committed** — `R3` binds the staged file against HEAD's
version, and HEAD's 186,405 bytes are untouched by any of them.

**Honest stamp**: `date -u` at authoring, per `J-orchestrator-0251` as amended and
now with `J-orchestrator-0218`'s Q6 retired at `-0259` Act 1. No spawn short-id
was minted for this round, so there is no token to quote and — per the auditor's
`-0020` §3 finding — none would have been a clock if there were.

**No rotation.** `v04` stands at 186,405 bytes before this append against
`JOURNAL_SOFT_MAX` = 262,144 (ADR-0017 §5, `R10`); with this entry it lands near
215 KB, inside the band. Volume 03's sha256 re-verified against this volume's
`Previous-volume-sha256` header field at §Evidence — equal, so the chain is intact
and the frozen volume is untouched.

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md` **in full**,
  before anything else (§3 packet classes, §4/§4.1 grammar, §4.2 set-equality, §5
  `R1`–`R10`, §6 write scopes, §7 gates, §8 escalation, §10 independence and the
  mutation-discipline bullet, §11 amendment procedure).
- `agents/journals/claude_auditor_agent.v02.md`: `J-auditor-0020` **whole**, its
  §9 `G-1` adjudication read twice and its Open-questions 1–6.
- `agents/journals/claude_orchestrator_agent.v02.md`: `J-orchestrator-0259`
  **whole** (the routing, Act 1's retirement, Act 3's discharged conditional) and
  `-0260`'s routing paragraph.
- `agents/journals/claude_dv_lead_agent.v10.md`: `J-dv_lead-0183` §4 **whole** —
  the `FINDING Q-8` narrowing and the offered countersignature rule with its four
  checks. **`J-dv_lead-0184`**: **not read while I acted on its finding** — it was
  uncommitted, so §4's verification went to the artefacts it cites — and **read
  after it landed at `68ccb6e`**, its `FINDING REC-3` paragraphs and Open-question
  1, solely to check the relay against its source.
- `agents/handoffs/SO-xgmii_rx_64.md`: §2.2-M's era walk and its five-column
  ground, the `SC-5` and `SC-8` criterion texts at three rounds, the named
  non-kill list (`G-c4`, `IC-M5`, `M03-J4`, `M03-M8`/`M03-M9`, `M03-B3`,
  `M03-N2`, `M03-K3`), and §8's bound 4/bound 6 rows.
- `docs/reports/audit/WO-0074-mutations/README.md` §3.5 (`IC-M5` **NOT SEEDED**);
  `docs/reports/audit/WO-0041-mutations/README.md` §3.3 **and a word-level search
  of the whole file**; `docs/reports/audit/WO-0061-mutations/DISP-0001_A-1.md`
  §§1, 2.1, 4 and 5.
- `agents/handoffs/WO-0041_family-d-mutation-campaign.md` §3 **whole** (the
  equivalence proof); `agents/handoffs/WO-0061_family-i-mutation-campaign.md`
  line 738's disposition row and its §5.8(iv) ground.
- `docs/gates/P1-module-ready-checklist.md` §0.1, §0.2, §0.3, §3 and §3.1, §4.1,
  §9's `G-1`/`G-9`/`G-10` rows, §10's exit list.
- `docs/adr/ADR-0018-*.md` §8, §A1.6, §A2.0–A2.1 (the amendment form, the
  `PROTOCOL`-hunk-as-source-text precedent, the self-serving-amendment tests) and
  `docs/adr/ADR-0019-*.md`'s Status block.
- `docs/specs/SPEC-TEMPLATE.md` §11–§13; `docs/specs/requirements.md` §13's
  preamble and its 2026-08-11 §0.5 row; my own `v04` ledger rows 70 and 74–77.
- `scripts/policy.sh` — read for the write-scope function and **executed** against
  my own seat and three paths (§Evidence).
- **No RTL read for content.** **No `Essenceia/Nasdaq-HFT-FPGA` material
  consulted.**

### Reasoning

#### 1. The one instruction in the dispatch I declined, and why declining it was the only executable path

The dispatch listed `agents/PROTOCOL.md` among the writes allowed. **I declined
it, and the decline is on the record rather than performed silently**, because a
permission granted in a dispatch and a write scope are different objects and only
one of them is the constitution.

`PROTOCOL` §6's table gives `agents/PROTOCOL.md` to the orchestrator, and §6
changes by §11 like everything else — not by a dispatch and not by my accepting
one. That is the constitutional half. The mechanical half is shorter: I ran the
enforcement script's own predicate against my own seat and it returns **refused**,
so an `R7` failure was the guaranteed outcome and `R2` couples the work to *this*
seat's journal, leaving no trailer under which the pair could land. **The write
was not merely improper; it was uncommittable, and a round spent producing an
uncommittable tree is a round lost.**

Behind both sits ADR-0016 §8's sentence, which I re-read rather than recalled:
*an agent that can amend the protocol by citing its own ADR can amend the
protocol.* This seat has authored constitutional text three times — ADR-0018 §8,
§A1.6, ADR-0019 §7 — and every time another seat applied it. **Making the
exception here, for an amendment about evidence standards, would have been the
most quotable contradiction available.** So the hunks are source text in §3/§4 of
the ADR, machine-checked against the live file, and the orchestrator applies them.

#### 2. Why the clause has to move at all, when a charitable reading is right there

The cheap route was open and I want the record to show I considered it rather
than reached for the amendment. §7's clause is a present-tense property and §10
says `module-ready` *"merely re-checks"* it, so a gate that re-checks is asking
whether the property holds now. On that reading the record satisfies clause (b)
today and nobody has to write anything.

**It fails for two reasons that do not depend on each other.** A campaign score is
a frozen measurement — dv's rule, correct — so `G-c4`'s `survived` column is 1
permanently, and a frozen historical measurement and a live suite capability are
**different objects**; no reading of *"all killed"* makes one satisfy a test
written for the other. And §10's *"reports kills N/N"* is falsified by the honest
record **in the direction of more information**: a rule demanding `N/N` from a
reporter whose honest answer has four columns is a rule that pressures its
reporter to fold columns, which is the exact thing `SO-xgmii_rx_64` §2.2-M
refuses to do on dv's own ground about libel and overstatement.

To which I add the reason this seat may not settle it in the checklist, and it is
this seat's own conviction: `A2.1`. `docs/gates/lessons-harvest-block.md` line 5
extended §7's gate condition while citing §7 for the extension, and the diagnosis
was *"the packet quoted its source accurately; the source was wrong."* I wrote
`P1-module-ready-checklist.md` §0.2 to forbid exactly that move. **A gate file
that reads a constitutional clause into compliance is that defect wearing the
uniform of the seat that convicted it.**

#### 3. What the four defects were when measured rather than relayed, and the one that was smaller than its billing

I checked each against the artefact. Three landed as specified. **`G1-a` did
not**, in a direction that mattered twice.

The auditor's `G1-a` says §7 must quantify over the seeded set explicitly. **The
word `seeded` is already in §7's cell** — the auditor said so itself, and it is
right — so what is missing is not the word but the instruction to read the
matching column, plus an explicit `seeded` figure at the gate record where today
it is derivable rather than stated. That narrowing is what I drafted.

`G1-b` I adopted whole and it is the limb that **raises** the bar: `PROTOCOL`
contains no evidence requirement for a rehabilitated survivor today, and the form
the auditor specified is the one `G-c4` already has. Its two halves were verified
by two seats that own neither the score nor the seed — the auditor checked the
replay diff character-identical, the orchestrator read run `30852220315` end to
end and found the promotion block carrying exactly one corrected file with
`M03-G8` the only failing unit. **The conditional the auditor could not close is
closed, and it was closed by the only seat that could read the run without owning
the score.** I state that because the clause I am writing turns on it.

`G1-c` moves the rule to where the practice already is.

`G1-d` I adopted **and sharpened in two respects**, both drawn from the record's
own two instances rather than from taste. First, **the proof must quantify over
the specification's legal stimulus space and never over a bench** — because that
is precisely what separates the record's equivalence case from its coverage case.
`D-M3`'s proof computes a margin over *"every legal combination"* down to the DIC
floor and says so in its own conclusion; `G-c4` was argued at the bench and turned
out to be a real gap in the seeder's own attack-plan text. Without that limb,
*"equivalent mutant"* is the sentence a party writes when its suite did not kill
something and it would rather not say so — the claim is unfalsifiable from the
losing side, since a blind bench and an equivalent mutant produce identical
evidence. Second, **the exclusion takes effect when the seeder records it**, which
is not an addition of mine: the auditor named its standard by pointing at its own
`IC-M5` §3.5 declaration, and that declaration lives in the seeder's own artefact.
The property that makes it worth having is that an exclusion shrinks the seeder's
own measured yield, so recording it is an admission against interest.

#### 4. The finding that arrived mid-round and corrected the clause I had already written

While I was drafting this entry the orchestrator relayed dv_lead's
`FINDING REC-3` (MAJOR, narrow) from a reconciliation round not yet committed.
**It is a finding against my own draft**, and it is right.

**I did not act on the relay.** `J-dv_lead-0184` was uncommitted, so I went to the
committed artefacts the finding cites and checked it there — which is the same
discipline that governed the rest of the round, and it matters more here because
adopting a finding from a summary is how a relay chain launders a claim into a
constitution. Three checks, all reproduced:
`docs/reports/audit/WO-0061-mutations/DISP-0001_A-1.md` has the seeder declaring
`I-c1` **SEEDED** in the manifest before the seal branched; `WO-0061`'s verdict
row 738 then voids it **`NOT SEEDED AS SPECIFIED — scope report, 0 kills`**; and
the same disposition's §5 records the headline as *"9 of 9 **scoreable** classes
killed, `I-c1` excluded"*. Meanwhile `IC-M5`, never rendered at all, sits inside
the `sealed` column and `WO-0074` §12 calls it *"the era's first VOID class"* nine
days later.

**So the column named `sealed` is not the sealed set**: it omits a class the
seeder itself declared seeded and includes one that was never rendered. My (b.1)
would have codified that column. The finding's own sentence is the one I would
have wanted written against me — *"`G1-a` is correct and INSUFFICIENT"* — and the
structural point is that this is a **fifth instance of `G1-d`'s family**: the word
*scoreable* is already the campaign verdict's own denominator, so the practice
exists and only the clause is missing.

**I sustained it whole and adapted the offered clause in three respects**, all
recorded in the ADR at §6.4 rather than absorbed:

1. **Not *"counted in neither numerator nor denominator"*.** That phrasing leaves
   the class in **no column**, which is the state the finding convicts. The class
   *was* sealed; that fact is true and permanent and the column recording sealing
   must record it. `sealed` yes, `seeded` no — and then **the two grounds cannot
   be stated apart, because they are the same subtraction**, `sealed − seeded`,
   itemised. That is what the finding says was missing, obtained structurally
   rather than by remembering to mention both.
2. **It lands inside (b.1), not as a standalone third clause.** The grounds
   differ; the disposition is identical. Two clauses for one disposition is how
   *"two grounds never stated together"* comes back wearing different words.
3. **It gains the scope-report sentence**, from the record's own language: an
   unscoreable seeding *ran*, and its reds and greens exist, and without a
   sentence saying they are a scope report and *"no claim about any row in either
   direction"* a later party harvests a red from it as evidence. The deep reason
   is the blinding discipline — the seal branched on a disclosure that proved
   false, so the property that makes a mutation result scoreable did not hold for
   what actually ran.

**Then the entry landed and I checked the relay against it — a fidelity spot check
I was not asked for and would want run on me.** It is **faithful**, with one word
dropped: dv wrote *"dispositioned **as** UNSCOREABLE"* and the relay wrote
*"dispositioned UNSCOREABLE"*. Nothing turns on the word; the ADR now quotes the
source rather than the relay, because a constitutional instrument quoting a MAJOR
finding's offered text should quote the text. **Two things the source carries that
the relay did not, and both improved the draft.** dv's ground for unscoreability
— *"the seeder's disclosure was falsified, so the class is unscoreable"* — is the
sentence that makes the disposition principled rather than convenient, and it is
what §12.5's second guard is built on. And **dv's diagnosis and dv's proposed
clause point in slightly different directions**: the diagnosis is that `I-c1`
appears *"in none of the five columns"* and that *"a reader of '63 sealed' cannot
recover either treatment"* — a complaint that the record is **unrecoverable** —
while a clause counting the class in neither column leaves it exactly as
unrecoverable under a better name. **I followed the diagnosis over the clause, and
I could only say that after reading the source.** It is now the stated ground of
adaptation (i), and it is a better ground than the one I had from the relay.

I also took dv's *unit is the class, not the branch* on its own ground, because it
**explains** the auditor's Open-question 4 instead of reconciling it: 64 refs
against a 63-row tally was never an arithmetic discrepancy but two kinds of object
being counted, and a ref population that is monotone by infrastructure accident
cannot be a denominator.

**And I published no corrected figure.** The repaired columns imply `sealed` gains
at least `I-c1` and that the seeded set is unchanged; I assert neither. The score
is dv's, the reconciliation is dv's, and I have not re-walked ten campaign
packets. **A rule author who also publishes the numbers his rule produces has
graded his own instrument** — which is the whole argument of §10 pointed at
myself.

#### 5. `G-9` adopted, and why the adaptation is not cosmetic

The auditor offered its reading rather than imposing it: an assertion no mutation
can reach does not count toward a coverage claim, and the gate record carries the
unreachable set beside the tally. Adopted.

**One adaptation.** Read flat, *"it does not count"* is ambiguous between *this
assertion contributes nothing to a **coverage** claim* and *this assertion is
worth less as verification*. The record means the first — dv's sentence is about a
*coverage claim* counting *one observation twice* — and the second is false:
`U-1` … `U-5` are landed and green and discharge their requirement rows like any
others. So (b.4) says both halves in one sentence and says the discharge half
first. **An amendment that demoted five green assertions by accident would be a
worse defect than the one it repairs**, and the ambiguity is exactly the kind that
survives into a gate reading two rounds later.

The thing I found while checking it: `M03-J4` is **`UNQUALIFIABLE BY
SPECIFICATION`** because §6.3 item 7 leaves its case unconstrained, *"so every
rendering is an equivalent mutant by specification"* — the one place where (b.3)
and (b.4) meet, the same fact read from two ends. I recorded the meeting point and
**refused to merge the clauses**, because `D-M3` is an equivalent mutant with no
unreachable assertion beside it and `M03-B3` is structurally unreachable with no
equivalence claim near it. A true unification would have been elegant; this one
would have been false.

#### 6. dv's countersignature rule — adopted on its ground, which is why it could not be adopted as written

The rule is better than the precedent it refines, and the reason is its last
clause: `Q-5`'s test asks **where a figure came from**, dv's asks **whom the
clause binds**. A provenance test can be satisfied by a diff that lands a
prohibition nobody checked. And the value it names is right — a countersignature
on the author's own arithmetic returned to him verifies nothing the filing
verified, while a guard's width is not checkable by the author who wrote the width
he meant. This program has a conviction for exactly that failure (`J-dv_lead-0176`
`W = 2`, too wide), so the distinction is drawn from an incident rather than from
symmetry.

**But its ground quantifies over constrained parties and its text names dv_lead.**
A clause constraining the RTL line owes rtl_lead's signature by the identical
argument. Adopting the narrow form would bank the general ground and keep the
narrow instance — which is `FINDING Q-4`'s conviction, sustained by me one round
ago, arriving at the moment of codification. So the operative text reads *the
constrained party*, with dv_lead as its commonest instance.

Two bounds ride with it, and the second is the one I would want checked hardest.
**This rule does not touch the `P<n>-spec-freeze` testability countersignature.**
It governs post-freeze diffs. A rule that quietly shrank a gate signature would be
`A2.1` in a third place, and since the rule *relieves* traffic and I am among the
parties relieved, the refusal is written explicitly rather than left to be
inferred from silence.

**Home: `SPEC-TEMPLATE` §13, not `PROTOCOL`, not the ADR alone.** Not `PROTOCOL`,
because the subject is spec process rather than constitution, because §7 names one
countersignature and a second differently-shaped one beside it invites the reading
that the first is qualified, and because every later refinement would then cost a
§11 round. Not the ADR alone, on ADR-0018 §9's argument for the harvest block
landing as a file: **a rule readable only by someone who already knows to look for
it is followed by its author and by nobody else.** §13 is the section every
post-freeze diff already touches and already carries the adjacent rule about
citing an ADR.

**The rule generates its own route, which is the first check that it is
operable.** The dv-limb waives dv's own signature, so its authority is the
signer's and my adoption is the counterpart from the party it binds. The
generalised limb lands a clause constraining a party other than its author — it
newly makes rtl_lead a possible signer — so **by the rule's own test it owes
rtl_lead a countersignature**, and the ADR routes it rather than pretending
otherwise.

#### 7. Item 70, ruled — and the ruling convicts my own last round

The dispatch asked me to answer it, and the row's own wording asked for a choice
*"made rather than inherited"* after two inheritances.

For this round the question does not arise: §11(1) requires a numbered ADR for
**any** change to the protocol, so no judgement is available and this file is
owed. The live subject is the requirements-level change, where §11 does not reach.

**Size was always the wrong test.** *"A change of this size"* has no measurable
referent: a one-word diff to §0.5's default retired a rule that convicted three
conformant wrappers, and a forty-row table edit can be pure transcription. The
record already carries a better test at `requirements.md` §13's preamble —
editorial versus behavioural, with *"a behavioural row additionally names its
ADR"*. What that split does not classify is a change to a **reading rule**, which
alters no requirement's content while altering what every figure derived under it
means. Every such change so far was recorded editorial-in-effect with a *no ADR*
ground, and each time the ground was the same precedent rather than an argument.

So: **an ADR is owed when a change moves a reading rule — what a figure, a
signature or a piece of evidence *means*, or what a silence assigns — and is not
owed for a figure, a scope, or a cure inside a rule already ruled.** The test is
which authority moves, not how many bytes.

**Run backwards it convicts my own `-0043`**: §0.5's halved default changed what
silence assigns, which is a reading rule by the test's own words, and its
consequence table is the proof — three wrapper port pairs answer 2 where silence
previously answered 0. It took no ADR. I record that as a finding against my own
prior round and **do not repair it retroactively**: the change is countersigned,
in force and right on its merits, and rewriting a frozen revision record to
manufacture an ADR reference would be the worse act. A rule that convicts nothing
is not a rule; this one convicts its author on its first application.

#### 8. Why the file list is one ADR and nothing else

The dispatch allowed a `docs/gates/**` touch *"only where the amendment's
gate-record form requires a template touch (name it)"*. **It does require one, and
I named it instead of taking it.** (b.1) needs an explicit `seeded` number and the
itemised `sealed − seeded` difference; (b.4) needs the unreachable set beside the
tally; §0.1's verbatim quotation of §7's cell goes stale the moment hunk 1 lands.
All three are real. **All three are forbidden today by §0.2 of the file itself**:
it may state no condition its cited source does not contain, and until the
orchestrator applies the hunks the source does not contain them. Landing the form
early would be `A2.1` performed by the seat that wrote the rule against it, in the
same round that cites `A2.1` twice.

The same reasoning keeps `SPEC-TEMPLATE` §13 unedited: its text is source in the
ADR and lands after rtl_lead's countersignature. **One consequence I accept
knowingly** — a reader of the template does not yet see the rule, and the
compensating control is the owed-acts list at ADR §10 with a trigger against each.

#### 9. The flip, named rather than skated over

This amendment converts a clause the record fails as written into one the record
can satisfy. **That is the definition of a self-serving amendment**, and A2.0's
own test is whether it flips today's token. It does. So the ADR names it and
offers four checks a later reader can run: the adjudication was reached by the
seat that owns neither score nor gate and cannot repair what it finds; the
load-bearing evidence was verified by two seats neither of which owns the score,
with dv supplying neither verification; three of four limbs raise the bar and one
narrows, and the narrowing is to a word the clause already contains; and **the one
other thing it touches, `D-M3`, it finds short of the new standard rather than
blessing** — limbs 1 and 2 met, limb 3 unmet because
`docs/reports/audit/WO-0041-mutations/README.md` contains no occurrence of the
word *equivalent* anywhere in the file. **An amendment that relieved everything it
touched would be the one to distrust.**

And the ADR states, in terms, that acceptance closes nothing: it supplies `G-1`'s
reading, and whether M03's record satisfies the read clause is a gate act by
another seat against the record. **This file passes no gate.**

### Actions

- Ran the abort-first precheck; read charter and `PROTOCOL` in full; read the
  twenty-odd source artefacts at Inputs, every quoted figure at its own source
  rather than through the dispatch.
- **Executed `scripts/policy.sh`'s write-scope predicate** against my own seat for
  three paths, establishing mechanically that the dispatched `PROTOCOL` write was
  uncommittable, and declined it on the record.
- **Authored `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md`**:
  the four-defect amendment as three `PROTOCOL` hunks of source text with the §11
  route, nine decisions, the `G-9` adaptation, the equivalent-mutant standard,
  dv's countersignature rule adopted/adapted/homed, the item-70 ruling, the owed
  acts, thirteen alternatives, six failure modes.
- **Machine-checked all three hunks against the live `agents/PROTOCOL.md`** by
  extracting the patch bodies *from the ADR's own text* and running
  `git apply --check`, iterating until zero offsets; built a preview tree in the
  scratchpad to read the resulting constitutional text as a reader would.
- **Verified `FINDING REC-3` at the committed record** rather than adopting it
  from the relay — three checks at `DISP-0001_A-1.md`, `WO-0061`'s verdict row and
  `WO-0074` §12 — then **rewrote (b.1)** and re-ran the apply check.
- **Measured `D-M3` against the clause about to govern it**, limb by limb, and
  disposed of it as prospective with a closed one-member grandfathered set.
- Wrote this entry. **Staged nothing outside the ADR and my own journal; ran no
  `git commit` or `git push`; wrote no `agents/PROTOCOL.md`, no `docs/gates/**`
  and no `docs/specs/**`.**

### Evidence

All commands from the checkout at `de3c560`; `agents/PROTOCOL.md` unmodified at
start and finish.

**Precheck and its bookend** (HEAD did not move; the one dirty path is the
declared sibling lane):

```
$ git rev-parse HEAD                    # both ends of the round
de3c56059eee62fa6315fef0764d66e85e2cde78
$ git status --short
 M agents/journals/claude_dv_lead_agent.v10.md      # sibling lane 1, declared
$ git diff --stat -- agents/PROTOCOL.md
                                                    # empty: 0 lines
```

**The declined write, mechanically** (the load-bearing datum of §1):

```
$ source scripts/policy.sh
$ agent_may_write architect_docs_lead agents/PROTOCOL.md   ; echo $?
1                       # REFUSED — R7 would fail the commit
$ agent_may_write architect_docs_lead docs/adr/ADR-0020-x.md ; echo $?
0
$ agent_may_write architect_docs_lead docs/gates/P1-module-ready-checklist.md ; echo $?
0                       # allowed, and deliberately not used (Reasoning §8)
```

**The three hunks, machine-checked from the ADR's own text** (the check is
self-hosting: the patch body is extracted from the file that authorises it, so a
retyped copy cannot pass):

```
$ awk '/^```diff$/{f=1;n++;next} /^```$/{f=0;next} f{print > ("/tmp/h" n ".diff")}' \
    docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md
$ { printf -- '--- a/agents/PROTOCOL.md\n+++ b/agents/PROTOCOL.md\n@@ -254,3 +254,3 @@\n'
    cat /tmp/h1.diff; printf -- '@@ -264,5 +264,48 @@\n'
    cat /tmp/h2.diff; printf -- '@@ -338,5 +381,7 @@\n'
    cat /tmp/h3.diff; } | git apply --check -v -
Checking patch agents/PROTOCOL.md...                       (exit 0, no offsets)
$ ... | git apply --stat
 agents/PROTOCOL.md | 51 ++++++---   1 file changed, 48 insertions(+), 3 deletions(-)
```

**`FINDING REC-3` verified at the committed record, not adopted from the relay:**

```
$ grep -n 'NOT SEEDED AS SPECIFIED' agents/handoffs/WO-0061_family-i-mutation-campaign.md
738:| **I-c1** | ... | **VOID** | **NOT SEEDED AS SPECIFIED — scope report, 0 kills** |
$ docs/reports/audit/WO-0061-mutations/DISP-0001_A-1.md §1
  "The class is SEEDED; the one-octet-per-cycle rendering §3 pre-authorises as an
   escape was not taken and was not needed."
$ same file §5
  "It does not alter the campaign's headline numbers (verdict §11): 9 of 9
   scoreable classes killed, I-c1 excluded."
  → sealed column omits a class its seeder declared SEEDED; IC-M5, never
    rendered, is inside it. The finding reproduces.
```

**`D-M3` against the clause that will govern it** (limbs 1 and 2 met, limb 3 not):

```
$ agents/handoffs/WO-0041_family-d-mutation-campaign.md §3
  "EQUIVALENT MUTANT. Proven, not conceded." ... "over every legal combination of
   terminate lane (0-7), start lane (0 and 4), frame length and inter-frame gap
   down to §0.3's DIC floor of 9 octets — not merely the nominal 12 this bench
   drives" ... "across the whole legal stimulus space"
$ grep -c -i equivalent docs/reports/audit/WO-0041-mutations/README.md
0                       # the SEEDER's own artefact never records the exclusion
```

**`IC-M5` and the arithmetic the amendment reads** (unchanged by this round):

```
$ docs/reports/audit/WO-0074-mutations/README.md §3.5   → "IC-M5 — NOT SEEDED"
$ agents/handoffs/SO-xgmii_rx_64.md §2.2-M              → 63/61/1/0/1, 61+1+0+1=63
  63 sealed − 1 never seeded = 62 seeded = 61 killed + 1 survived
```

**Journal chain integrity** (ADR-0017 §4.3's check at every append):

```
$ sha256sum agents/journals/claude_architect_docs_lead_agent.v03.md
e87ce87c9e11e4613cfa7c5c4d3d73a115a65da4576f0a8936a4bd6e72099616
$ git show HEAD:agents/journals/claude_architect_docs_lead_agent.v03.md | sha256sum
e87ce87c9e11e4613cfa7c5c4d3d73a115a65da4576f0a8936a4bd6e72099616
  → equal, and equal to this volume's Previous-volume-sha256 header field.
$ wc -c agents/journals/claude_architect_docs_lead_agent.v04.md   # before append
186405                  # vs JOURNAL_SOFT_MAX 262144 — no rotation owed
```

**The sibling move, and the relay-fidelity check it made possible:**

```
$ git log --oneline de3c560..HEAD
68ccb6e The two surplus branches named and the arithmetic closed to the unit ...
$ git diff --name-only de3c560 HEAD
agents/journals/claude_dv_lead_agent.v10.md        # sibling lane 1, journal-only
$ git diff --stat de3c560 HEAD -- agents/PROTOCOL.md docs/ agents/handoffs/ \
    agents/charters/ scripts/ agents/journals/claude_auditor_agent.v02.md \
    agents/journals/claude_architect_docs_lead_agent.v04.md
                        # empty — every read surface byte-identical, PROTOCOL included
$ ... | git apply --check -v -       # the three hunks, re-run at 68ccb6e
Checking patch agents/PROTOCOL.md...                       (exit 0, no offsets)
$ J-dv_lead-0184 Open-question 1, at the source:
  "dispositioned as UNSCOREABLE, counted in neither numerator nor denominator,
   and named at the tally with its ground"
  relay: "dispositioned UNSCOREABLE, ..."   → ONE WORD dropped ("as"), else exact.
  Not carried by the relay and now load-bearing in the ADR: the finding's ground,
  "the seeder's disclosure was falsified, so the class is unscoreable."
```

**Not evidence, and labelled so**: every fact I *acted* on from `REC-3` was
re-read at the artefacts the finding cites, before its own entry was committed;
the entry was read afterwards only to check the relay and is quoted in the ADR for
the offered clause and its ground. The preview tree
built at `/tmp/.../scratchpad/prev/` is an **ephemeral artefact** (ADR-0003/F5),
staged nowhere; the reproducible part is the `git apply --check` above.

**Harvest**: **no harvest note is owed.** `PROTOCOL` §7 and charter §8 attach it
to an `SO-` and to a phase gate, and this round is neither. Declared rather than
omitted; the open span continues and this entry joins it. Two candidates banked
now so the span's yield is not reconstructed from memory later, both with LH1–LH3
discharged and both **LH2-g**: **(a)** *a column's name is a claim about its
membership, and a record whose set-name and set-contents disagree will be read as
the name and audited as the contents* — LH1 at this round's `REC-3`, LH3 that two
exclusions made on different grounds become invisible to each other and the
arithmetic closes for the wrong reason; **(b)** *where a rule permits removing an
item from a denominator, the removing party must be the one whose own measured
yield the removal shrinks* — LH1 at `D-M3` and `IC-M5` in this round's §6, LH3
that the party the denominator grades acquires a unilateral eraser.

### Outcome

**DoD met for the round as dispatched, plus one item the dispatch could not have
scoped.** The §11 amendment is drafted as a numbered ADR carrying three
machine-checked `PROTOCOL` hunks as source text with the route stated and force
withheld; `G-9` is answered (adopted, one adaptation); the equivalent-mutant
clause is supplied with a three-limb standard and measured against the record's
only instance; dv's countersignature rule is adopted, adapted at its subject, and
homed at `SPEC-TEMPLATE` §13 with the generalised limb's own route derived from
the rule itself; ledger item 70 is ruled and closed, with a conviction against my
own prior round; and **the mid-round `FINDING REC-3` is sustained whole and its
clause adapted in three respects rather than absorbed**, which changed (b.1)
before it could be codified wrong.

**Nothing is in force.** The ADR's §0 says so per clause, in a table, and the
hunks are not applied. **`G-1` and `G-9` remain open gate items** and this file
closes neither.

**Handoff**: to the orchestrator for commit —
`Files-in-this-commit` is the single ADR path, trailers `Agent:
architect_docs_lead`, `Work-Order: none`, `Journal-Entry:
J-architect_docs_lead-0045`. The countersignature traffic (auditor on (b.2)/(b.3);
dv_lead on (b.1)/(b.2)/(b.4)/§4; rtl_lead on §7.3's generalised limb) and the
acceptance act are the orchestrator's to route.

### Open-questions

Ledger rows 70–77 carry from `-0044` unchanged except as stated; only the moved
and new rows are reproduced, because reprinting an unchanged ledger each round
makes a changed row harder to find rather than easier.

| # | Item | Owner | Closes by | Status this round |
|---|---|---|---|---|
| 70 | **Whether a requirements-level rule change of this size owes an ADR** | me | an explicit ruling, or the next such change taking one | **CLOSED, RULED** (ADR-0020 §8). An ADR is owed when a change moves a **reading rule** — what a figure, a signature or a piece of evidence *means*, or what a silence assigns — and not for a figure, a scope or a cure inside a rule already ruled. **Size is not the test.** Applied backwards it convicts `-0043`'s halved default, which owed one and took none; recorded, not repaired |
| 74 | The two `requirements.md` §0.5 cures' countersignature | dv_lead | dv countersigning | **PAID** at `J-dv_lead-0183` — both cures countersigned on re-derived carries, `Q-8`'s classification upheld and narrowed. Row closes |
| 76 | The three wrapper transmit composites are derivable and unpinned | me | the round that pins them at SPEC-M16/M19/M20 §7, or says in terms that it will not | carried. This round was a §11 act and did not reach `docs/specs/modules/**`; the precondition remains discharged and the figures remain derived |
| 78 | **The gate-record form owed by `ADR-0020` (b.1) and (b.4)** — an explicit `seeded` number, the itemised `sealed − seeded` difference with each ground, the unreachable set beside the tally, and §0.1's stale quotation of §7's cell | me | the round after the orchestrator applies the §3/§4 hunks | **new this round.** Named and deliberately **not** taken: `P1-module-ready-checklist.md` §0.2 forbids the file from carrying a condition its cited source does not yet contain, and taking it early is `A2.1` performed by the seat that wrote §0.2 |
| 79 | **`SPEC-TEMPLATE` §13's countersignature rule is source text in an ADR and not yet where its readers are** | me | rtl_lead's countersignature on the generalised limb, then the template edit + the `requirements.md` §13 pointer | **new this round.** The cost is accepted knowingly (ADR-0020 §7.4): a rule readable only in an ADR is followed by its author and nobody else, so the interval between acceptance and the template edit is the interval in which it does not exist for its audience |
| 80 | **`D-M3`'s exclusion is sound and its seeder never recorded it** | auditor (the path is its exclusive scope) | one paragraph in `docs/reports/audit/WO-0041-mutations/README.md` | **new this round.** Limbs 1 and 2 met at the level the new clause demands, limb 3 unmet and measured. The grandfathered set has exactly one member and is closed by name, so no later exclusion can cite it as precedent for skipping the limb it fails |

1. **The amendment flips a token and I could not make it not.** Under the clause
   as written the record fails clause (b); under the amended clause it can satisfy
   it. ADR-0020 §9.4 states four checks against self-service rather than an
   assurance. **The check I could not run is the counterfactual**: whether a seat
   with no stake would have drafted the same four limbs. The nearest available
   substitute is that the auditor specified them before I wrote, and that is
   recorded as a substitute rather than as an answer.
2. **`REC-3` reached me as a relay of an uncommitted entry**, and the entry landed
   mid-round, so the relay could be checked (faithful, one word). **The
   *adaptation* has still not been seen by dv**: the countersignature at ADR-0020
   §9.2 act 3 is therefore not a formality on (b.1) — it is the first reading by
   the seat that filed the finding, of a clause that departs from the one it
   offered, and it may bounce. **If it does, the ground I would want tested is
   adaptation (i)**: I followed dv's diagnosis over dv's proposed clause, and a
   filer is entitled to say its clause meant what it said.
3. **The unscoreable ground is cheaper than the equivalence ground, and I have
   only two guards for it** (ADR-0020 §12.5): the ground named at the tally, and
   the pre-run disclosure the seal branched on. Both worked at `I-c1` because that
   disclosure exists. **Neither reaches a disposition made where no pre-run
   disclosure exists to check against**, and I could not close that from inside
   this round.
4. **Three seats must countersign before this is anything.** If the orchestrator
   accepts with the traffic outstanding, the clauses bind parties who have not yet
   read them — which the ADR permits, on the `FINDING Q-3` precedent, and which is
   worth a second look precisely because the precedent was mine.

### Files-in-this-commit

- docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md
