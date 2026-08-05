# WO-0072: family K — `clear` (M03-K1, M03-K2), the LAST bench round of this module, and the one port no bench in this suite has ever driven

| Field | Value |
|---|---|
| **Packet** | `WO-0072` |
| **State** | `DRAFT` → `ISSUED` on spawn |
| **From** | dv_lead (`J-dv_lead-0130`) |
| **To** | tb_writer, via the orchestrator |
| **Base** | `f6a51ce` (branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`) |
| **Rows** | `M03-K1`, `M03-K2` — both ASSERT, both REQ-009. `M03-K3` is `NO-ASSERT` and is **not** in this round |
| **Commissioned by** | `RV-0071-VERDICT` §7 item 1 |
| **Context provided** | SPEC-M03 (`docs/specs/modules/xgmii_rx_64.md`) §§6.1–6.3, §7, §9, §10; `docs/specs/requirements.md` §0.3, §0.5, §0.6, §0.7, §12, REQ-009, REQ-011, REQ-015; `test/attack_plans/AP-xgmii_rx_64.md` §2, §4.K, §7; `test/xgmii_rx_64/bench.mli`; `test/xgmii/{arrival,frame,xgmii_word}.mli`; `test/monitors/{conservation,protocol,strobe}_monitor.mli`, `octet_time.mli`, `stream_word.mli`; this packet. **No `libs/**`, no `top/**`, no `rtl_snapshots/**` — do not open them** (PROTOCOL §10) |

---

## Section map

| § | What it is |
|---|---|
| **0** | What this round is, and the two things that make it different from every round before it |
| **1** | The capability — the `Clear` schedule: what the rows require, the shape, the three losing shapes |
| **2** | The cycle-0 lesson, REUSED and not copied — the two places a transplant of family J's design would have broken this round |
| **3** | The guard — refuse-to-drive, its subject, its entry condition, and what it must **not** refuse |
| **4** | The monitor feed — `Protocol_monitor.on_clear`, its home, and the ordering that is derived rather than chosen |
| **5** | The compatibility bar — the 56 landed units, and the checks that prove it |
| **6** | The derivation base — `Arrival`'s own arithmetic, re-derived at this tree |
| **7** | **M03-K1**, derived: stimulus, constants, assertions, the control run, and its declared kill audited |
| **8** | **M03-K2**, derived: stimulus, constants, assertions, the accounting, the control run, and its declared kills audited |
| **9** | **The disposition classes for a K2 red — pre-committed, before any cycle is driven** |
| **10** | Two findings against my own machinery, paid here because no later carrier exists |
| **11** | The structural witness |
| **12** | Cost — the size class WO-0070 measured, and this round's pre-committed ceiling |
| **13** | Unit structure, and the files this round stages (scope) |
| **14** | The review bar — pre-committed, assigned by seat |
| **15** | BOUNCE conditions — pre-committed |
| **16** | Traps — named so they are not discovered |
| **17** | The worker's terms — the enumerated tool allow-list, the durability clause, the substitution clause |
| **18** | What this round does NOT close, and what I owe after it |
| **19** | Your return |
| — | Return / verdict log |

---

## 0. What this round is, and the two things that make it different from every round before it

Family K is the **last bench round of `Xgmii_rx_64`**. After it, `SO-xgmii_rx_64.md`
is reachable (the mutation campaigns for families L and M, PROTOCOL §10-sequenced,
stand between it and a PASS — §18).

Two facts set this round apart, and both are load-bearing.

**(1) `clear` is a port no bench in this suite has ever driven.** `Bench.create`
drives it high for exactly one reset cycle and then releases it, and from that
moment on nothing in `test/**` touches it again. Family J faced the same shape
one port over and built the `Enable` schedule (X-6) for it; **this round builds
the same kind of instrument for `clear` and its consumers in one commit.** The
machinery is not new — the *stimulus discipline* is: this is the first and only
place in the module where a new stimulus is still genuinely owed.

**(2) The design risk is real and it is concentrated in M03-K2.** Every family
since D has driven a stimulus whose conformant answer this suite had already seen
in a neighbouring shape. K2 has not: it asks the design to drop a frame it has
already begun emitting, **with no `tlast` and no strobe** — the one place in this
specification where a frame vanishes without a report (SPEC-M03 §9's own
sentence) — and then to accept a start character on the very next cycle. §9 of
this packet pre-commits what each possible red **means**, before any cycle is
driven, because a disposition invented after a red is not a disposition.

**A consequence that must be stated out loud, to the orchestrator as much as to
the worker: nobody in this org can see K2's verdict before the commit lands.**
The worker has no compiler beyond `ocamlc -stop-after parsing` (ADR-0005) and I
have none at review time either. The first observation of K1's and K2's result is
the CI `build` run **at the landing commit**. A red there is an **expected
possible outcome of this round**, it is information about the design, and it is
**not** a reason to revert the commit — it is routed to me and adjudicated
against §9. That is how `BUG-0001`, `BUG-0002` and `BUG-0003` were all found; the
exposure is the programme's normal operating mode, not an accident of this
packet.

---

## 1. The capability — the `Clear` schedule

### 1.1 What the two rows require, derived from the rows and from nothing else

Read off §4.K and REQ-009, before any shape is chosen:

- **(R-a)** A row must be able to say *"`clear` is 1 on cycles f … l and 0
  everywhere else"* as a **construction**, not as a hand-written predicate at a
  call site. Both rows need a **contiguous window**; neither needs anything else.
- **(R-b)** The window's endpoints are derived from `Arrival`'s own start cycles
  (K2's release cycle **is** frame B's start cycle), so the schedule must be
  built where those cycles are in scope — i.e. passed to `run`, not to `create`.
  This is the five-call-sites-each-hand-computing-an-off-by-one shape this
  programme has paid for three times (`RV-0057-VERDICT` Finding 1, `RV-0062`
  FINDING B-1, `WO-0067` §1.3(d)).
- **(R-c)** The value **as driven** must be readable back off each cycle's
  sample, so a row asserts the window it drove rather than the window it
  declared. This is M03-I2 member (iii)'s *"construction and landing checked at
  both sites"*, applied to a third port.
- **(R-d)** The bench must **refuse** a stimulus whose outcome the specification
  does not determine, before a single cycle is driven (§3).
- **(R-e)** The port must reach the design through the **same choke point** the
  XGMII word and `cfg_rx_enable` already reach it through, so there is exactly
  one place in this file where a stimulus port is written.
- **(R-f)** A run that does not name the capability must be **byte-for-byte the
  old run** — no new branch, no new evaluation of `word_at`, no new exception
  class (§5).

### 1.2 The shape — `Clear` declared in `bench.mli`, consumed by `run`

**This is what you build.** In `test/xgmii_rx_64/bench.mli` and `bench.ml`:

```ocaml
(** A [clear] schedule: which cycles of a run drive REQ-009's synchronous clear.
    The reset cycle {!create} drives is OUTSIDE every schedule and is not
    governed by this type — see {!create}. *)
module Clear : sig
  type t

  (** 0 for the whole run. The DEFAULT, and byte-for-byte the behaviour every
      unit landed before WO-0072 was written against. *)
  val never : t

  (** [window ~first ~last] — 1 on cycles [first] .. [last] INCLUSIVE, 0 on
      every other cycle. Raises unless [0 <= first] and [first <= last],
      because a window whose end precedes its start is a window its author did
      not mean. [first = 0] is legal and means "extend the reset": {!create}'s
      own reset cycle already drove [clear] = 1, so a window opening at cycle 0
      is a longer reset and nothing else. *)
  val window : first:int -> last:int -> t

  (** The value driven on [cycle]. Total, like [Arrival.word_at]. *)
  val value_at : t -> cycle:int -> bool

  (** The cycles at which the driven value is 1, ascending; [[]] for
      {!never}. This is the SUBJECT of {!run}'s pre-scan guard, and {!run}
      enters that guard on this set being non-empty — a projection of the
      subject, never a separate predicate that reconstructs it
      (WO-0068 §7.3's rule, applied at the design rather than at a repair). *)
  val high_cycles : t -> int list

  (** [not (List.is_empty (high_cycles t))] — the guard's entry condition,
      named so the condition and its subject are the same object. *)
  val is_ever_high : t -> bool

  (** A deterministic diagnostic rendering, for failure messages. NOT for an
      expect block — `WO-0067` §5.5's rule still governs and this docstring
      does not withdraw it. *)
  val report : t -> string
end
```

`run` gains **one optional argument, after `?enable` and before the terminal
`unit`**:

```ocaml
val run
  :  t
  -> Dv_xgmii.Arrival.t
  -> drain:int
  -> ?word_at:(cycle:int -> Dv_xgmii.Xgmii_word.t)
  -> ?enable:Enable.t
  -> ?clear:Clear.t          (* NEW; defaults to [Clear.never] *)
  -> unit
  -> sample list
```

and `sample` gains **one field, after `enable`**:

```ocaml
type sample =
  { cycle : int
  ; in_word : Dv_xgmii.Xgmii_word.t
  ; enable : bool
  ; clear : bool                (* NEW *)
  ; out : Dv_monitors.Stream_word.t
  ; after_out : Dv_monitors.Stream_word.t
  ; errors_high : string list
  }
```

**Why `clear` belongs in `sample`, derived and not decorative.** The ground is
`enable`'s, verbatim, one port over: `sample` already carries `in_word` and
`enable` — the stimulus **as driven** — so that a row proves its stimulus landed
where it intended. `clear` is the same object at the same choke point under the
same `Before` convention. Both K rows assert *"this cycle was a clear cycle and
the design was silent on it"*; without the field, a row whose window landed one
cycle off has no instrument that can say so, and its silence assertion would be a
statement about a window nobody measured. See trap **T3**.

### 1.3 The three losing shapes, and the defect that loses each one

**(a) `changes ~initial:bool [(cycle, value)]` — family J's own constructor,
transplanted.** This is the shape a reader reaches for first, and it is the one
this packet spends §2 rejecting. It loses on two counts, the first structural and
decisive. First, `~initial` expresses a cycle-0 transition **that no author
declares**, which is exactly the mechanism that produced `RV-0067-VERDICT` §6.2's
guard gap; a window constructor has no `initial`, so cycle 0 is high iff `first =
0`, declared, and there is no implicit transition for any derived function to
reconstruct incompletely. Second, and specific to this port: for `clear` the
value in force before cycle 0 is **1** (`create` drives it through the reset
cycle), so `never` — the default — would itself be a schedule with `initial =
false` and a real 1 → 0 boundary transition. Any guard entered on a transition
set being non-empty would therefore be entered on **every landed run in this
suite**, which is precisely what (R-f) forbids. §2 works this through.

**(b) A `create` parameter — `val create : ?clear:… -> unit -> t`.** `create` is
where `clear` is driven today, so the current docstring invites it. It loses on
**(R-b)** decisively: K2's window ends on frame B's own start cycle, a number
that exists only once `Arrival` has laid the schedule out, and `create` is called
on the other side of that. It loses again on **(R-d)**: the guard's subject is
the coincidence of a clear cycle with a **driven word**, and `create` sees no
words. A capability whose constraint must be enforced somewhere other than where
it is declared is the shape `idle_injection.mli` refused and `WO-0067` §1.3(a)
rejected. Third and smaller: `create`'s body is this file's statement of the
**invariant** wiring; `clear` is now the variable part of the stimulus.

**(c) A `high_cycles : int list` set constructor — `Clear.of_cycles [6;7;8;9;10]`.**
This is the most tempting, because the guard's subject **is** the high set and
this constructor is that set. It loses on **(R-a)** and on legibility of intent:
the two things a row must get right are the window's two ENDPOINTS, and a list
literal states neither — a row that meant 6..10 and wrote 6..9 has written a
well-formed schedule that no construction check can question, whereas
`~first:6 ~last:10` puts both endpoints on the page beside the cycles they were
derived from. It also invites a non-contiguous set, which REQ-009 gives no
meaning to at this module and which no row in this plan wants. **Rejected, and
named here so it is not re-invented in the Return log.** (`high_cycles` survives
as the derived **observation**, which is a different thing from an author's
declaration — the same `changes`/`change_cycles` split `bench.mli` already
documents for `Enable`, reached here by the opposite route.)

### 1.4 One detail of the chosen shape, stated so it is not decided by accident

`create` keeps driving `clear` = 1 through its reset cycle, **unchanged** (§5's
bar depends on it), and keeps setting the port low immediately after. That cycle
is outside every schedule, exactly as `bench.mli` already says of `Enable`. The
`Clear.t` schedule governs from **cycle 0** of `run`. Where a schedule's window
does not open at cycle 0 there is therefore a real 1 → 0 transition between the
reset cycle and cycle 0 — **it exists, nothing in this design reads it, and §2
says why that is a conclusion rather than an oversight.**

---

## 2. The cycle-0 lesson, REUSED and not copied

`RV-0067-VERDICT` §6.2 found that family J's guard entry condition was **one
transition short of its own subject**: the pre-scan was entered on the
*declared changes* being non-empty rather than on the *observed transitions*, so a
schedule built with `Enable.low` (`initial = false`, `changes = []`) never
entered the guard even though it carried a genuine 1 → 0 transition at cycle 0.
`WO-0068` §7.3 repaired it **at the subject** — `change_cycles` now reports the
boundary transition it observes, so the entry test is a projection of the subject
and cannot drift from it — and banked the general form in `AP-xgmii_rx_64.md`
§7's X-6 row:

> *a guard whose subject is a derived set must be entered on that set, never on a
> hand-written predicate that reconstructs it.*

**That rule is what this round reuses. The `(0, false)` prepend is what this
round must NOT copy, and there are two independent places where copying it would
have broken this round.** Both are stated here rather than left for the Return
log, because the transplant is the natural thing to do and it is wrong twice.

**(i) The polarity of the reset drive is inverted, so the DEFAULT becomes the
special case.** For `cfg_rx_enable`, `create` drives **1**, and the default
schedule `Enable.high` has `initial = true` — the default agrees with the reset
drive and reports no boundary transition. For `clear`, `create` drives **1** and
the default schedule is **never** = 0 for the whole run. Under a literal
transplant, `Clear.never` would report `[(0, false)]`, the guard's entry
condition `transitions ≠ []` would be TRUE for `Clear.never`, and **every one of
the 56 landed units would enter a walk it does not today**, evaluating `word_at`
`total` extra times and gaining an exception class it cannot raise today. That is
`WO-0067` §2 clause 4 and BOUNCE **B10** violated by the copy, on the very run
that omits the argument. **BOUNCE `BK4`.**

**(ii) The guard's subject is a different set, so the transition set is the wrong
projection.** Family J's guard fires on a *change* coinciding with a start
character, because §6.3 item 7 leaves the outcome of a change on a start
character's own cycle undetermined. This round's guard fires on a *high cycle*
coinciding with a start character (§3). Its subject is therefore
**`high_cycles`**, and `is_ever_high` is that set's projection. A transition set
is neither: it is non-empty for schedules whose high set is empty (see (i)) and
it says nothing about which cycles are high.

**And the transplant would have refused this round's own K2 stimulus.** Family
J's predicate — *"a driven-value change on a cycle carrying a start character"* —
is TRUE at K2's release cycle by construction: the clear goes 1 → 0 on cycle 11
and cycle 11 carries frame B's start character. REQ-009's last sentence makes
that placement **required reading, not undefined behaviour**: *"a frame whose
start character arrives on the first cycle after `clear` returns to 0 is received
correctly."* A copied guard refuses the one stimulus §4.K exists to commission.
**BOUNCE `BK5`.**

**The reusable form, and it is the round's own contribution to the bank:** *a
guard's entry condition must project the guard's own subject, and its subject must
be re-derived per port — two ports of the same module can share a schedule's
shape and have different subjects, different reset polarities, and opposite
verdicts on the same coincidence.*

---

## 3. The guard — refuse-to-drive

### 3.1 What it checks

Before a single cycle is driven, and **only when `Clear.is_ever_high clear`**,
`run` walks cycles `0 .. total - 1`, and for every cycle `c` at which
`Clear.value_at clear ~cycle:c` is `true` it evaluates the word this call would
actually drive on `c` and tests
`Dv_xgmii.Xgmii_word.start_lane (word_at ~cycle:c)`. Every cycle at which that
returns `Some lane` is collected. If the collection is non-empty, `run`
**`failwith`s naming every such cycle and its start lane**, citing REQ-009,
SPEC-M03 §6.2's `Idle` row and §7's reset bullet.

### 3.2 Why it refuses, and the ambiguity it mechanises — derived from the spec's own two sentences

This is not prudence. **The specification contains two readings of a start
character arriving while `clear` = 1, and settles neither.**

- **§6.2's `Idle` row**: entered by *"reset; `clear`; a frame ends normally or is
  aborted"*, and its transition column is *"`Preamble` on `/S/` in lane 0 or lane
  4 while `cfg_rx_enable` = 1"* — **with no `clear` = 0 qualifier**. Read alone,
  a `/S/` under `clear` opens a frame.
- **§7's reset bullet**: *"While `clear` = 1 and on the first cycle after it
  returns to 0: `tvalid` = 0, all five strobes 0, **state `Idle`**"*. Read alone,
  the state is held in `Idle` while `clear` = 1, so the transition is squashed.

The two cannot both be applied literally on a cycle that carries both a `/S/` and
`clear` = 1. And the reading that reconciles them for the **release** cycle — the
state named is the state *during* that cycle, with the transition taking effect
for the next, which is exactly how a normal start character behaves and is what
makes REQ-009's last sentence consistent — is the reading under which §7 says
**nothing at all** about whether a `/S/` under `clear` is latched.

So the outcome is undetermined, and a bench that drove it and asserted either
answer would be flaky by construction. **The disposition is `Idle_injection`'s
inverse, and for the reason `WO-0067` §3 already derived at this file**: that
module *records and still applies* an illegal placement, deliberately, because
its illegal stimulus produces a **determinate wrong answer** (REQ-105's abort) a
bench cannot miss. Here there is **no determinate answer to assert against**, so
a recorded-and-applied run would certify coverage of a stimulus the specification
does not constrain. Record-and-apply there; refuse-to-drive here. Put this
paragraph's substance in `bench.mli`'s `run` docstring, in your own words.

**The spec-side half is an observation, not a blocker** — the guard removes any
need for a ruling before this round can land. It is recorded at §18 item 4 for
the next spec queue: §6.2's `Idle` row's transition column should carry
`and clear = 0`, or §7 should say which of the two governs. **Do not raise it
yourself and do not edit `docs/**`** — that is outside your scope and mine.

### 3.3 Why it reads the DRIVEN word and never `Arrival.start_cycles`

Restated because it is the single most likely thing to get wrong, and because
family J paid for stating it: at M03-N4 the start character is placed by
`Dv_xgmii.Injection` and arrives through `?word_at`; it is **absent from
`Arrival` entirely**. A guard built on `Arrival.start_cycles` reports clean on
exactly the stimulus class the guard exists for. **Checking against `Arrival` is
BOUNCE `BK6`**, and it is a bounce even though neither row in this packet drives
an injected start character.

### 3.4 What the guard must NOT refuse — three cases, each named

1. **A clear window whose LAST cycle is followed by a start character on the
   release cycle.** This is M03-K2's own stimulus and REQ-009's last sentence
   blesses it in terms. The guard tests **high cycles**, and the release cycle is
   not high. **BOUNCE `BK5`.**
2. **A clear window opening at cycle 0.** `create` already drove `clear` = 1
   through the reset cycle, so this is a longer reset and is ordinary. No row
   here drives it; the constructor admits it and the guard has no special case
   for it, which is a derivation to check rather than a convention to adopt.
3. **A terminate or error character on a clear cycle.** §6.2's `Idle` row says
   the state *"ignores every lane"*, which is unambiguous for `/T/` and `/E/` and
   ambiguous only for `/S/`. K2 drives frame A's own `/T/` on cycle 10, inside
   its clear window, **deliberately** (§8.4 kill 1c). The guard tests
   `start_lane` and nothing else.

### 3.5 Where the walk sits

After `Arrival.check sched` and after the M03-J4 enable pre-scan, before the
first `sample_cycle` — the same *"nothing is driven until the stimulus has been
checked"* position, for the same stated reason. The two pre-scans are independent
and neither reads the other's schedule.

---

## 4. The monitor feed — `Protocol_monitor.on_clear`

### 4.1 Its home is `run`, and that is derived

`protocol_monitor.mli` says of its own contract:

> *"Anything across a `clear`. REQ-009 and REQ-015 require the monitor to reset
> its frame-in-progress state on `clear` and make no assertion across it;
> `on_clear` is how a bench discharges that, and it is why a truncated in-flight
> frame is not reported as a violation."*

`run` is already the only place the protocol monitor is fed, and `bench.mli`
already states why: *"C-23's counting convention requires every cycle, including
ones where nothing is high, so `run` is the only place that call is allowed to
happen."* `on_clear` is a per-cycle feed of the same monitor keyed on the same
schedule. If a row called it, the row would have to re-state which cycles are
high — the duplicated-idiom-with-a-hand-computed-boundary shape (R-b) exists to
kill. **`run` calls `Protocol_monitor.on_clear t.protocol ~cycle` on every cycle
where the driven `clear` is 1, and a row never calls it.** Calling it from a row
is BOUNCE `BK7`.

### 4.2 The ordering inside the cycle is DERIVED, not chosen

Within `sample_cycle`, the landed order is `Protocol_monitor.observe`, then
`Strobe_monitor.sample`. **`on_clear` goes LAST**, after both. Two grounds:

1. **Compatibility.** A run with `Clear.never` makes zero `on_clear` calls, so
   the landed call sequence is byte-identical rather than merely equivalent.
2. **Discrimination, which is the real reason.** `on_clear` increments
   `cleared_mid_frame` only when `words_this_frame > 0`, and `observe` zeroes
   `words_this_frame` on a `tlast`. Consider K2's declared kill — a design that
   emits a phantom `tlast` on a clear cycle. Under **observe-first**, that word
   is counted as a completed frame, `words_this_frame` returns to 0, `on_clear`
   finds nothing in progress, and `cleared_mid_frame` is **0** — so the row's
   `cleared_mid_frame = 1` assertion reds **in addition to** its own no-`tlast`
   assertion: two independent reds naming the same defect from two instruments.
   Under **on_clear-first**, `cleared_mid_frame` would be 1 (from the two words
   that legitimately escaped) and only one red would fire. Observe-first is
   strictly more discriminating on exactly the failure this round is built to
   catch.

State the resulting three-call order in the Return log verbatim from your own
code.

---

## 5. The compatibility bar — the 56 landed units

**The bar.** *Every unit landed before this round must be byte-identical in its
source, in its promotion block and in the code path it drives. The capability is
reached only by naming it.*

Five clauses:

1. **`create`'s type does not change.** `val create : unit -> t` stays exactly as
   it is, and its body's reset drive is untouched.
2. **`run`'s existing arguments do not move.** `?clear` is added after `?enable`
   and before the terminal `unit`, so every existing `Bench.run` call site
   compiles and behaves unchanged with no edit.
3. **No existing `test_m03_*.ml` file is touched**, with the single exception of
   `test_m03_structural.ml`, which gains one appended unit and nothing else
   (§11). The other twelve do not appear in your write record. Not one line, not
   one comment.
4. **The default path is the old path by construction, not by intention.** The
   §3 pre-scan is entered **only when `Clear.is_ever_high`**. `Clear.never` has
   an empty high set, so a `run` with `?clear` omitted enters no new branch,
   evaluates `word_at` exactly as many times as it does today, and can raise no
   exception this round introduces. **The one operation it does gain is a single
   `Bits.t ref` write per cycle** — `i.clear := Bits.gnd` — and that is
   deliberate and is the same cost `i.cfg_rx_enable` already pays unconditionally
   at this choke point today. Driving the port only when the schedule is ever
   high would put a second true statement about the stimulus in the file; one
   unconditional write matches the port beside it. State the guard's exact entry
   expression in the Return log.
5. **`sample`'s new field breaks nothing, and this is MEASURED, not assumed.**
   `WO-0067` clause 5 measured this for `enable` before family J, L and N landed;
   **re-measure it at this tree** — no file outside `bench.ml` constructs a
   `sample` or matches one exhaustively. If you find a counter-example, that is a
   finding to report, not a thing to work around, and it does not bounce you.

### 5.1 The checks

**Bar A — the twelve untouched test files, byte-identical.** For each of
`test_m03_{a,b,c,d,e,f,g,h,i,j,l,n}.ml`: they are not in your write record. This
is proved by clause 3 and by §14 bar `K-3`, not by an edit you then undo.

**Bar B — `bench.ml`'s string-literal multiset is a strict superset,
enumerated.** Every literal you add is listed in the Return log with **one line
of justification each**, naming which of the four new mechanisms it belongs to
(the `Clear.window` construction check, the §3 guard's message, `Clear.report`'s
rendering, `account_cleared_frame`'s refusal message). **No literal may be
removed or changed** — a removal is BOUNCE `BK8`. `bench.mli` gains no literal at
all: everything added there is a comment or a signature.

**Bar C — the promotion blocks could not tell.** Every `[%expect {…}]` block in
the twelve untouched files is byte-identical, and the two in
`test_m03_structural.ml` are untouched. Every new block in this round is `{||}`.
This is the clause that would catch a capability that changed the DUT's observed
behaviour rather than merely its options.

---

## 6. The derivation base — `Arrival`'s arithmetic, re-derived at this tree

Derived at `f6a51ce` from `test/xgmii/arrival.ml`'s `create` and
`requirements.md` §0.3, not recalled. **You assert these; you do not re-derive
them — but you do CHECK them, and a disagreement with any number of mine is a
finding I want (§19 item 3).**

`Arrival.create`'s layout, at `ifg = 12`, `first_start = 8`, `floor_gap =
min 12 9 = 9`, `credit = 0`: for a 64-octet frame at start octet time `s`,
`terminate = s + 8 + 64 = s + 72`; `shorten = min 0 3 = 0`; `target = s + 84`;
`next = round_up_4 (s + 84) = s + 84` (already a multiple of 4, so the credit
never moves and the DIC path is never taken).

| quantity | definition | source |
|---|---|---|
| `start_cycle f` | `f.start_octet_time / 8` | `arrival.ml:21` |
| `terminate_octet_time f` | `start_octet_time + 8 + length` | `arrival.ml:22` |
| `Arrival.cycles t` | `((terminate_octet_time last + ifg + 7) / 8) + 1` | `arrival.ml:119-126` |
| output word `m` | emitted on cycle `start_cycle + m + 3` | SPEC-M03 §6.1's `m + 3` |
| delivered octets, clean 64-octet frame | `64 − 4 = 60` (REQ-103 strips the FCS) | SPEC-M03 §9 row 1, REQ-103 |
| output words, 60 octets | `ceil(60 / 8) = 8`, last word `tkeep` = `0x0F` | REQ-011, REQ-021 |
| `h` (front offset) | `strip_octets + start_lane` = **8** at lane 0, **12** at lane 4 | `octet_time.ml:7` |
| `L` | `8ΔC − h` = **16** at h = 8, **12** at h = 12; `ΔC` = **3** at both | SPEC-M03 §7, §0.5; re-derived `WO-0070` §3 |

**Gaplessness**, which every `m + 3` figure above depends on: for each frame the
preamble occupies `s … s+7`, the octets `s+8 … s+71`, the terminate character
`s+72`, and nothing is injected between them — `Arrival` emits idle only in the
gap. The condition is **per frame**; the inter-frame gap lies outside the span it
constrains, so a gapped run is still a gapless stimulus for each of its frames.

---

## 7. M03-K1 — `clear` for five cycles with no frame in flight

> **§4.K row, verbatim.** *Attacks*: REQ-009. *Stimulus*: `clear` = 1 for 5
> cycles while no frame is in flight. *Observable*: `tvalid` = 0 and all five
> strobes 0 on every `clear` cycle **and on the first cycle after it returns to
> 0**. *Kills*: a design whose strobe registers survive `clear`, or that needs a
> second cycle to settle. *Status*: ASSERT.

### 7.1 The stimulus, and why it carries a strobe

A clear window over dead air asserts *"nothing appeared where nothing was"* and
separates no design from any other. **The row's declared kill — strobe residue —
is only reachable if a strobe pulses immediately before the window.** So the
stimulus is: **one 64-octet frame with a corrupted FCS at start lane 0, whose
`error_bad_fcs` pulses on its own `tlast` cycle, with the clear window opening on
the very next cycle.**

`error_bad_fcs` is chosen over `error_runt` for three derived reasons: the frame
is forwarded **in full** (§9 row 1), so its delivered extent is the ordinary
clean-frame identity and needs no `?expected_octets`; its strobe cycle is pinned
by §9's *"Strobe cycle, pinned"* to the `tlast` cycle, which this suite has
already derived and landed at M03-D1; and the frame's construction has a
pre-existing both-directions anti-vacuity check (`WO-0040` §3.2) that costs six
lines and proves the corruption did what it claims.

The frame builder is `Bench.directed_frame_octets ~length:64` with bit 0 of the
octet at index 20 flipped **after** the FCS was computed — family D's own
construction (`test_m03_d.ml:33-56`), reproduced in `test_m03_k.ml` **with a
citation to it**, not imported from it. **Duplicating four lines with a citation
beats a cross-row dependency between two test files that share no other subject**;
say so in a comment at the site so a reader does not read it as an oversight.

### 7.2 The derived constants — every one of them

`bad = flip bit0 at index 20 of (directed_frame_octets ~length:64)`;
`sched = frames_at ~lane:0 ~fcs_valid:false [ bad ]`; `bench = create ()`;
`samples = run bench sched ~drain:8 ~clear:(Clear.window ~first:12 ~last:16) ()`.

| # | quantity | derived value | derivation |
|---|---|---|---|
| 1 | `Array.length (Arrival.frames sched)` | **1** | one frame given |
| 2 | frame 0 `start_octet_time` | **8** | `first_start = 8` at lane 0 |
| 3 | frame 0 `start_lane` | **0** | `8 mod 8` |
| 4 | `Arrival.start_cycle frame` | **1** | `8 / 8` |
| 5 | `Arrival.terminate_octet_time frame` | **80** | `8 + 8 + 64` |
| 6 | terminate cycle | **10** | `80 / 8` |
| 7 | `Arrival.cycles sched` | **13** | `((80 + 12 + 7) / 8) + 1 = 12 + 1` |
| 8 | cycles driven, `~drain:8` | **21**, i.e. cycles `0 … 20` | `13 + 8` |
| 9 | `List.length samples` | **21** | one per driven cycle |
| 10 | delivered octets | **60** | `64 − 4`, REQ-103 |
| 11 | output words | **8** | `ceil(60 / 8)` |
| 12 | delivered cycles, in order | **4, 5, 6, 7, 8, 9, 10, 11** | `start_cycle + m + 3`, `m = 0 … 7` |
| 13 | `tlast` cycle | **11** | `1 + 7 + 3` |
| 14 | `tkeep` on words 0 … 6 / word 7 | **0xFF** / **0x0F** | 60 = 7×8 + 4, REQ-011 |
| 15 | `tuser` on the `tlast` word | **1** | REQ-104, §9 row 1 |
| 16 | `error_pulses samples` | **exactly `[ (11, "error_bad_fcs") ]`** | §9's pinned cycle = the `tlast` cycle |
| 17 | `Strobe_monitor.expect` event | `cycle` **11**, `not_before` **10**, `not_after` **13**, `frame` **0** | §0.6's window around the terminate cycle; M03-D1's own registration |
| 18 | delivered octet sequence | `Dv_xgmii.Frame.delivered bad` | REQ-005: forwarded in full, corruption included |
| 19 | clear window | cycles **12 … 16** inclusive, five cycles | opens on the cycle after the strobe (item 16), five cycles is §4.K's own figure |
| 20 | the release cycle | **17** | `16 + 1`; REQ-009's *"the first cycle it is 0"* |
| 21 | `s.clear` is `true` iff | `12 ≤ s.cycle ≤ 16` | item 19, read off the sample |
| 22 | `Protocol_monitor.cleared_mid_frame` | **0** | `words_this_frame` was zeroed by the `tlast` at cycle 11, so no `on_clear` call finds a frame in progress — **this is the assertion that says the clear did NOT interrupt anything** |
| 23 | `Conservation_monitor` | `frames_in` **1**, `frames_out` **1**, `frames_exempt` **0**, `discards` **0**, `residual` **0** | one frame in, one emitted |
| 24 | `Latency.observed` | one class, `front_offset` **8**, `latencies` **[16]** | lane 0; `L = 24 − h` |
| 25 | `Latency.word_delay` | **`Some 3`** | `(16 + 8) / 8` |

**No cycle in 12 … 16 carries a start character** — the schedule's only start
character is at cycle 1, cycle 12 is the schedule's trailing gap and 13 … 20 are
drain idle — so §3's guard finds nothing and the run proceeds. Check this
yourself before you write the window down; if it fires, §9's class **D4a**
governs and the defect is mine.

### 7.3 What M03-K1 asserts, in order

The order is part of the specification: **a count or a set is asserted before
anything consumes it**, so a wrong observation can never be masked by an
accounting call that quietly succeeded on it.

1. Construction, before the run: `Frame.residue_ok good` is **true** and
   `Frame.residue_ok bad` is **false** (`WO-0040` §3.2's both directions —
   without the second, a corruption that did not corrupt makes this row green for
   the wrong reason). Then items 1–7 of §7.2's table, checked against the
   schedule.
2. `Strobe_monitor.expect` registered with item 17's event **before** the run.
3. The delivered stream: item 11's word count, item 12's cycle list, items 13–15,
   item 18's octet sequence.
4. `error_pulses samples` equals item 16 **exactly**, as a list — not "contains".
5. **The clear window as driven**: for every sample, `s.clear` equals item 21's
   predicate. A schedule that landed one cycle off fails here and not by
   accident.
6. **The silence**: for every sample with `12 ≤ s.cycle ≤ 17` — the five clear
   cycles **and the release cycle** — `s.out.tvalid` is **false** and
   `s.errors_high` is **empty**. This is REQ-009's observable, verbatim.
7. Accounting: `account_clean_frame bench frame samples ~aborted:false`, then
   `Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_bad_fcs"`.
   **Both calls are family D's own, at `test_m03_d.ml:171-172`, and this round
   copies them rather than improving them** — see §10 OBSERVATION K-O1 for the
   one thing about `~aborted:false` that is worth recording and is **not** this
   round's to change.
8. Item 22, item 23's five counters, item 25.
9. The control run (§7.4).
10. `assert_monitors_clean bench ~row` and `assert_monitors_clean control ~row`.

### 7.4 The control run — mandatory, and its purpose is NOT family J's

A second, fresh `create ()` drives **the same schedule with `?clear` omitted**,
`~drain:8`. Then: the two runs' **delivered streams are compared for equality** —
the same 8 words, the same 8 cycles, the same 60 octets, the same `tlast` cycle,
`tkeep` and `tuser`, and the same single `error_bad_fcs` pulse at cycle 11.

**Why, stated precisely, because it is easy to mis-sell.** M03-J1's control
proved the *schedule* carried well-formed frames, because J1's silence could
otherwise have been caused by an empty schedule. That risk does not exist here:
K1's own frame is received inside the clear run itself, at item 3. The control's
purpose is different and it is charged: **it pins the clear window's leading
boundary.** A design that applies `clear` one cycle early loses the `tlast` at
cycle 11 and the two runs differ; a design that applies it one cycle late shows
output at cycle 12 and step 6 reds. Together, the control and step 6 bracket the
window's boundary from both sides.

**And here is what the control also proves, which is uncomfortable and is stated
rather than hidden: cycles 12 … 17 are silent in the control run too.** In a
**conformant** design the clear window is not differentiable at the output,
because nothing was pending when it opened. That is not a defect in the row; it
is the exact content of *"while no frame is in flight"*. K1's separating power
lives entirely in designs that would have presented something — §7.5.

### 7.5 M03-K1's declared kill, audited — one reachable, one FORBIDDEN

§4.K's Kills cell names two classes. They do not fare the same, and the
difference is derived here before a bench exists, which is where the four
previous instances of this finding were also made.

**Kill (a) — "a design whose strobe registers survive `clear`". REACHABLE, and
tightly placed.** M03's strobes are combinational in the current XGMII word
(SPEC-M03 §6.1's one-word lookahead; `BUG-0001`'s R-1 finding is the evidence).
An implementation that instead registers a strobe output and does not gate that
register with `clear` presents cycle 11's `error_bad_fcs` again on cycle 12 —
inside the window, caught by step 6, and caught a second time by the
`Strobe_monitor`'s `unexpected` list, since only one pulse is registered.
**Opening the window on cycle 12 rather than later is what makes this class
reachable at all**, and that is why the placement is tight rather than
comfortable.

**Kill (b) — "or that needs a second cycle to settle". NOT SEPARATED BY THIS
ROW'S OWN STIMULUS. The claim is FORBIDDEN.** Worked through:

- A design whose `clear` takes effect **one cycle late** behaves un-cleared on
  cycle 12 — and on cycle 12 a conformant design also produces nothing, because
  the frame drained at cycle 11. **Invisible here.**
- A design that needs **an extra cycle to go quiet after release** has nothing to
  show on the release cycle 17, because nothing was pending when the window
  opened. **Invisible here.**
- The only member of the class this stimulus does separate is narrow: a design
  that *suppresses without resetting* and re-presents the suppressed strobe on
  the release cycle. That is a real class and step 6's release-cycle clause
  catches it — but it is **not** the general class the cell names.

**THE HONEST KILL, and it is this row's own**: *a design whose strobe path
survives `clear` — either by presenting a pre-clear strobe inside the window, or
by holding it suppressed and re-presenting it on the release cycle* — plus, from
the control run, *a design whose clear gating is off by one cycle at the leading
edge*.

**Where the forbidden class DOES live: M03-K2.** K2's window opens over a frame
with six output words still to come and closes on a cycle carrying a start
character, so a design needing an extra settling cycle either emits a held word
on the release cycle or fails to accept B's start character there — both caught,
both asserted. **This is the M03-D3 / M03-F2 / M03-I2 / M03-J2 / M03-N4 shape at
its SIXTH instance**, and it takes the same disposition it took the five previous
times: **the row stays ASSERT** — its observable is REQ-009's own words and §4.K
commissions it in terms — what changes is **the claim a round may make about it**.
**No `SO-`, campaign scorecard or verdict may cite M03-K1 as detecting a design
that needs a second cycle to settle.** The `AP-` cell repair is §18 item 2's, in
the batched plan round, not this packet's; and **no assertion, comment, docstring
or Return-log sentence in `test_m03_k.ml` may claim it** (BOUNCE `BK9`).

---

## 8. M03-K2 — `clear` mid-frame, released onto a start character

> **§4.K row, verbatim.** *Attacks*: REQ-009, §7's reset bullet. *Stimulus*:
> `clear` asserted **mid-frame**, deasserted, and a new frame whose start
> character arrives on the **first** cycle after `clear` returns to 0.
> *Observable*: the in-flight frame vanishes with **no `tlast` and no strobe**;
> the new frame is received correctly and completely. The conservation monitor
> records the abandoned frame as `frame_in_exempt ~reason:"clear"` — without that
> exemption a conformant M03 fails (C-2 at its first module). *Kills*: a design
> that emits a `tlast` on `clear` (a phantom frame downstream); a design that
> needs one idle cycle before it can accept a start character; a monitor that
> counts the abandonment as a silent discard. *Status*: ASSERT.

### 8.1 The stimulus, and the one arithmetic fact that makes it buildable

Two 64-octet frames with **correct** FCS at start lane 0, distinguished by their
sequence numbers so that the frame delivered after the clear can be identified as
B and not as a resumption of A:

```
a = Dv_xgmii.Frame.stress_frame ~sequence:0 ()
b = Dv_xgmii.Frame.stress_frame ~sequence:1 ()
sched = frames_at ~lane:0 ~fcs_valid:true [ a; b ]
```

**The arithmetic fact**: at the default 12-octet gap, frame B's start character
lands at octet time `8 + 84 = 92`, i.e. **cycle 11, lane 4** — and cycle 11 is
exactly one cycle after a five-cycle window closing at cycle 10. **The default
schedule already places B on the release cycle; no `?ifg` is needed and none is
passed.** That is why the window is `~first:6 ~last:10`.

**"The first cycle after `clear` returns to 0" means the release cycle itself,
and this packet pins that reading before any red exists.** REQ-009's own words
are *"on every cycle `clear` = 1 **and on the first cycle it is 0**"*; §7's reset
bullet is *"while `clear` = 1 **and on the first cycle after it returns to 0**"*.
They are the same clause of the same requirement, so *"the first cycle after it
returns to 0"* is *"the first cycle it is 0"* — cycle **11** in this row's
numbering, not cycle 12. Both halves of REQ-009 then hold together without strain
on cycle 11: `tvalid` = 0 and all strobes 0 there (no output word is due on a
start character's own cycle in any case, since `ΔC` = 3), **and** B is received
correctly. §9's class **D5** is what happens if this reading is disputed.

### 8.2 The derived constants — every one of them

`bench = create ()`;
`samples = run bench sched ~drain:8 ~clear:(Clear.window ~first:6 ~last:10) ()`.

| # | quantity | derived value | derivation |
|---|---|---|---|
| 1 | frames in the schedule | **2** | two given |
| 2 | A: `start_octet_time` / `start_lane` / `start_cycle` | **8** / **0** / **1** | `first_start = 8` |
| 3 | A: `terminate_octet_time` / terminate cycle | **80** / **10** | `8 + 8 + 64`; `80 / 8` |
| 4 | B: `start_octet_time` / `start_lane` / `start_cycle` | **92** / **4** / **11** | `80 + 12 = 92`, already a multiple of 4; `92 mod 8 = 4`; `92 / 8 = 11` |
| 5 | B: `terminate_octet_time` / terminate cycle | **164** / **20** | `92 + 8 + 64`; `164 / 8` |
| 6 | `Arrival.start_spacings sched` | **[10]** | `11 − 1` |
| 7 | `Arrival.gaps sched` | **[12]** | `92 − 80` |
| 8 | `Arrival.cycles sched` | **23** | `((164 + 12 + 7) / 8) + 1 = 22 + 1` |
| 9 | cycles driven, `~drain:8` | **31**, i.e. cycles `0 … 30` | `23 + 8` |
| 10 | clear window | cycles **6 … 10** inclusive, five cycles | §8.3 |
| 11 | the release cycle | **11** = B's start cycle | §8.1 |
| 12 | A's output words **without** clear would be at | 4, 5, 6, 7, 8, 9, 10, **11** | `1 + m + 3` |
| 13 | **A's delivered words, WITH clear** | **exactly 2**, at cycles **4** and **5** | `tvalid` = 0 on every clear cycle (REQ-009), and the window opens at 6 |
| 14 | A's delivered `tkeep` on both words | **0xFF** | full words; REQ-011 |
| 15 | A's delivered octet count | **16** | 2 × 8 |
| 16 | A's delivered octets | the **first 16** of `Dv_xgmii.Frame.delivered a` | REQ-005 cut-through: no word is withheld, so what escaped is a prefix |
| 17 | **A's `tlast`** | **none, anywhere in the run** | REQ-009: *"truncated with no `tlast` and no `strobe`"* |
| 18 | B's delivered words | **8**, at cycles **14 … 21** | `11 + m + 3` |
| 19 | B's `tlast` cycle / `tkeep` / `tuser` | **21** / **0x0F** / **0** | `11 + 7 + 3`; 60 = 7×8+4; clean frame |
| 20 | B's delivered octets | `Dv_xgmii.Frame.delivered b`, **60** octets | REQ-103 |
| 21 | `Frame.sequence_of` of B's delivered octets | **1** | `stress_frame ~sequence:1`, REQ-020 |
| 22 | the run's complete delivered-cycle list | **[4; 5; 14; 15; 16; 17; 18; 19; 20; 21]** | items 13 and 18 |
| 23 | `error_pulses samples` | **`[]`** — empty | A vanishes with no strobe (REQ-009); B is a clean, correct-FCS, 64-octet frame with nothing in §9's table to pulse |
| 24 | `s.clear` is `true` iff | `6 ≤ s.cycle ≤ 10` | item 10 |
| 25 | `Protocol_monitor.cleared_mid_frame` | **1** | `words_this_frame` = 2 when the first `on_clear` fires at cycle 6; the remaining four calls find 0 |
| 26 | `Protocol_monitor.frames` / `words` / `aborts` | **1** / **10** / **0** | one `tlast` (B's); 2 + 8 words; no `tuser` bit |
| 27 | `Conservation_monitor` | `frames_in` **1**, `frames_out` **1**, `frames_exempt` **1**, `discards` **0**, `residual` **0** | §8.3 |
| 28 | `Latency.observed` | class `front_offset` **8** → `latencies` **[16]**; class **12** → **[12]** | A at lane 0 with 16 octets; B at lane 4 with 60 |
| 29 | `Latency.word_delay` | **`Some 3`** | both classes close at `(L + h) / 8 = 3` |
| 30 | `Latency.frames_compared` | **2** | A and B both compared |

**Cycle 10 carries frame A's own terminate character, inside the clear window,
and that is deliberate** — see §8.4 kill 1c. §3's guard tests `start_lane` only,
so it does not fire; the schedule's two start characters are at cycles 1 and 11,
neither of which is high.

### 8.3 Why the window is 6 … 10, and the accounting that follows from it

**`last = 10`** is forced: the release cycle must be B's start cycle, which is
11.

**`first = 6`** is chosen and the choice is derived. It must be ≥ 5 for the
abandonment to be *mid-output* at all (A's first word is at cycle 4), and it must
leave the window five cycles long so that **K1 and K2 differ only in placement,
not in duration** — §4.K gives K1 the figure 5 and a controlled pair is worth
more than two arbitrary windows. At `first = 6`, exactly **two** of A's eight
words escape, which is the smallest count that lets the row assert a multi-word
**prefix** (proving the escaped words are contiguous and correctly ordered)
rather than a single word.

**The accounting, and it is the row's C-2 content.** Frame A was *presented*, was
*accepted*, emitted two words, and then vanished with no `tlast` and no strobe.
Under `requirements.md` §0.6 it is therefore neither *emitted* (that term counts
output `tlast`s) nor *discarded* (that term requires a strobe, and REQ-009
explicitly licenses none). Counting it through `frame_in` would put it into an
equation that has no term for it and would report **a silent discard where
REQ-009 says there is none** — a conformant M03 failing its own conservation
monitor, which is precisely the failure C-2's exemption ledger exists to prevent.
So:

```
A : Conservation_monitor.frame_in_exempt ~reason:"clear (REQ-009)"
B : the ordinary account_clean_frame path
```

This makes M03-K2 the **second consumer of C-2's exemption in `test/**`**, after
M03-J1 — and `AP-xgmii_rx_64.md` §7's dated note (2026-08-09) records that until
this round *"it is still not true of M03-K2."* It becomes true here.

**The caution rides with the demand, as it does at M03-J1**: the exempt count is
**bench-supplied**. It counts the call this unit made, not anything the DUT did,
and **no `SO-` may cite it as evidence that a frame was driven.** The honest
evidence for the drive is the schedule's own two-frame array plus the mandatory
control run (§8.5).

**The new accounting entry point.** None of the four landed entry points fits: all
four call `Conservation_monitor.frame_in`, and two of them call `discarded`,
which requires a strobe. Add to `bench.mli`/`bench.ml`:

```ocaml
(** Standing obligations 2 and 3 for a frame the module ACCEPTED and then
    ABANDONED under REQ-009's synchronous clear: presented, partially emitted or
    not emitted at all, with no output [tlast] and — REQ-009's own explicit
    licence, the one place in SPEC-M03 where a frame vanishes without a report —
    no strobe.

    Conservation: [frame_in_exempt ~reason:"clear (REQ-009)"], NEVER [frame_in]
    and never [discarded]. The §0.6 equation has no term for such a frame:
    counting it as presented reports the silent-discard hole REQ-009 disclaims,
    and attributing it to a strobe requires a strobe that specification forbids
    (`conservation_monitor.mli` deviation 3).

    Latency: [frame_in] fed [Arrival.in_times frame], then — on [delivered] —
    either [frame_out ~expected_octets:delivered] against [samples]'s own
    delivered octet times, or, at [delivered = 0], [frame_dropped], which pops
    the pending input frame without a comparison because there is no output
    frame to compare.

    [samples] must be THIS frame's own delivered words and no others, and
    [delivered] must be a value the caller has already ASSERTED rather than
    observed — the branch above is selected by that number, so a number taken
    from the run it is meant to judge would let a wrong observation choose its
    own accounting. *)
val account_cleared_frame
  :  t
  -> Dv_xgmii.Arrival.frame
  -> delivered:int
  -> sample list
  -> unit
```

`delivered < 0` raises. For K2, `delivered = 16` (item 15), asserted at step 3
below before this call is made.

### 8.4 What M03-K2 asserts, in order

Again the order is part of the specification.

1. Construction, before the run: items 1–8 of §8.2's table against the schedule,
   including `Arrival.is_clean sched`. **Item 4's `start_cycle = 11` is the
   number the whole row rests on**; if it is not 11, stop — §9 class **D4b**.
2. Confirm no cycle in 6 … 10 carries a start character (§3's guard would fire
   otherwise; checking it in the row makes the intent explicit rather than
   relying on the absence of an exception).
3. **The delivered-cycle list of the whole run equals item 22, exactly, as an
   ordered list.** This is the precondition of every partition below and it is
   asserted **before** any partition is taken. See trap **T1**.
4. Partition: A's words are the first **2** of the delivered list, B's are the
   remaining **8**. Then A: items 14, 15, 16. B: items 18, 19, 20, 21.
5. **No `tlast` anywhere before B's** (item 17 and item 19 together): the only
   sample in the run with `tlast` = 1 is the one at cycle 21.
6. **`error_pulses samples` is empty** (item 23), asserted as a list equality.
7. **The clear window as driven**: `s.clear` equals item 24's predicate on every
   sample.
8. **The silence across the window and the release cycle**: for every sample with
   `6 ≤ s.cycle ≤ 11`, `s.out.tvalid` is **false** and `s.errors_high` is empty.
   This covers the five clear cycles, **the terminate character at cycle 10**,
   and **the release cycle 11**.
9. Accounting, in this order: `account_cleared_frame bench frame_a ~delivered:16
   a_words`, then `account_clean_frame bench frame_b b_words ~aborted:false`.
10. Items 25, 26, 27's five counters, item 29.
11. The control run (§8.5).
12. `assert_monitors_clean bench ~row` and `assert_monitors_clean control ~row`.

### 8.5 The control run — mandatory, and here it is charged exactly as M03-J1's was

A fresh `create ()` drives **the same schedule with `?clear` omitted**,
`~drain:8`, and asserts: **16** delivered words; **two** `tlast` samples, at
cycles **11** and **21**; A's 60 octets equal `Frame.delivered a` and B's equal
`Frame.delivered b`; `Frame.sequence_of` gives **0** then **1**;
`error_pulses` empty; `cleared_mid_frame` **0**; conservation `frames_in` 2,
`frames_out` 2, `frames_exempt` 0, `residual` 0; `Latency.word_delay` `Some 3`.

**Its purpose**: without it, a schedule that never carried a well-formed frame A
at all — a construction error, not a design fact — would make K2 green, because
"A vanished" and "A was never there" have the same output. A's own two escaped
words are *some* evidence and they are not enough: they say nothing about the six
words that follow, about A's `tlast`, or about A's FCS verdict. **BOUNCE `BK10`
if it is absent.**

Note the cycle coincidence in the control, and do not read it as an error: A's
`tlast` is at cycle 11 and B's start character is at cycle 11. Those are opposite
directions of the same cycle and both are correct.

### 8.6 M03-K2's declared kills, audited

**Kill 1 — "a design that emits a `tlast` on `clear` (a phantom frame
downstream)". REACHABLE, at three distinct sites, and this is the round's
principal attack.**

- **1a — at the window's opening edge (cycle 6).** A design that treats `clear`
  as *"close the current frame"* rather than *"abandon it"* emits a `tlast` on or
  just after cycle 6. Caught by step 5, by step 8, and — independently — by step
  10's `cleared_mid_frame = 1`, which becomes 0 when `observe` counts the phantom
  as a completed frame (§4.2).
- **1b — at the release edge (cycle 11).** A design that holds the abandoned
  frame's closure and emits it when `clear` lifts. Caught by step 8, whose window
  deliberately includes the release cycle.
- **1c — at frame A's own terminate character (cycle 10), inside the window.** A
  design that latches the `/T/` while cleared and closes the frame on release.
  This site exists **because** the window was placed to cover A's `/T/`, and it
  is derived from §6.2's `Idle` row (*"ignores every lane"*), which is
  unambiguous for `/T/`.

**Kill 2 — "a design that needs one idle cycle before it can accept a start
character". REACHABLE, and this is the tightest legal placement.** REQ-009's last
sentence names the release cycle specifically; B's start character is on it.
Such a design either produces nothing for B (step 4 finds 2 delivered words
instead of 10, and step 3 fires first) or produces B late (step 3's cycle list
disagrees). **This is also where M03-K1's forbidden kill legitimately lives**
(§7.5).

**Kill 3 — "a monitor that counts the abandonment as a silent discard". NOT A
DESIGN KILL, and it is reclassified rather than dropped.** The call the row makes
is the row's own; no design can cause it to be wrong. What this cell states
correctly is that **the C-2 exemption path is a precondition of the row**: with
`frame_in` in place of `frame_in_exempt`, a *conformant* M03 shows `residual` = 1
and `assert_monitors_clean` reds. So it is a statement about the monitor
contract, discharged by §8.3's derivation and by the row's own
`frames_exempt = 1` assertion — **not** an attack this row mounts against the
DUT, and no `SO-` may count it as one. **No `AP-` edit is owed for this**: the
cell is true as written; what it is not is a design kill, and that distinction is
recorded here.

**No kill of M03-K2's is withdrawn.** All three cells stand; one is reclassified
from design-kill to monitor-precondition. K2's declared attack surface is
reachable under K2's own stimulus, which is the answer to the question §4.K's
Kills column exists to ask.

---

## 9. The disposition classes for a K2 red — PRE-COMMITTED

**Fixed here, in a committed artefact, before a single cycle is driven** — the
`BUG-0003` §V.10.3 / `WO-0070` §1.5 shape: a rule written before the run and then
applied to a result nobody could re-read afterwards. **I apply this table, in
writing, in this packet's Return log, against the CI `build` run at the landing
commit.** No worker applies it.

| Class | Tell — what is observed at CI | Disposition |
|---|---|---|
| **D1** | A `tlast` = 1 delivered word inside cycles 6 … 11, or any `tlast` attributable to frame A | **DESIGN. `BUG-` packet to rtl_lead**, citing REQ-009, §7's reset bullet and §9's *"the one real exception … is `clear` asserted mid-frame"*. The row stands; the bench is not touched. This is the phantom-frame class and it is the one this round exists to find |
| **D2** | Frame B absent, short, or delivered on cycles other than 14 … 21 | **DESIGN. `BUG-`**, citing REQ-009's last sentence verbatim. The "needs one idle cycle" class |
| **D3** | `tvalid` = 1 or any strobe high on a cycle in 6 … 11, with no `tlast` | **DESIGN. `BUG-`**, citing REQ-009's first clause. Distinct from D1 because a leaked word is not a phantom frame and the two have different root causes |
| **D4a** | The run raises `Bench.run: clear is asserted on a cycle carrying a start character` | **BENCH — MINE.** My cycle arithmetic in §8.2 is wrong. No design conclusion may be drawn. Repair the packet, re-issue |
| **D4b** | A construction assertion at step 1 or 3 fires (`start_cycle ≠ 11`, `cycles ≠ 23`, the delivered-cycle list disagrees while the stream is otherwise conformant) | **BENCH — MINE**, unless the disagreement is itself a design fact. The row's construction checks run **before** its design assertions precisely so this class is separable |
| **D4c** | `Conservation_monitor.residual ≠ 0` while the stream is exactly as §8.2 predicts | **BENCH — the worker's.** `frame_in` was called where `frame_in_exempt` was specified (§8.3). Repair in `test/**`; no design conclusion |
| **D4d** | `cleared_mid_frame ≠ 1` while two words were delivered and no `tlast` appeared | **BENCH — the worker's.** `on_clear` was not fed, or was fed before `observe` (§4.2). Repair in `test/**` |
| **D5** | Frame B is absent **and** rtl_lead disputes that *"the first cycle after `clear` returns to 0"* is the release cycle rather than the cycle after it | **SPEC.** My reading and its ground are pinned at §8.1 **before** any red exists. Per charter §7, a CRITICAL bug disputed as spec ambiguity goes to **architect_docs_lead immediately** for adjudication, with §8.1 as my filed position. I do not re-derive the reading after seeing the result |
| **D6** | M03-K1 red while M03-K2 green, or vice versa | Adjudicate each on its own row. The two share no run, no bench and no stimulus; there is no shared-cause class to invoke |

**What is NOT a disposition class, stated so it cannot be reached for**: reverting
the commit, weakening an assertion, widening a window, or converting a row to
`NO-ASSERT` because it went red. A red here is the instrument working.

---

## 10. Two findings against my own machinery, paid here — because no later carrier exists

**This is the last bench round of this module. A bench-machinery debt parked here
has no carrier.** That is the whole ground for paying both below in this commit
rather than naming a future round for them. Both are **comment-only**: if either
changes one character of executable code, that is BOUNCE `BK11`.

### 10.1 FINDING K-1 — `conservation_monitor.mli`'s deviation 3 states a ground narrower than its own correct use

Deviation 3 reads:

> *"A frame presented while `clear` is asserted (REQ-009) or while receive-enable
> is 0 (REQ-810) is never accepted, so it is neither emitted nor discarded …"*

**M03-K2's frame A was presented BEFORE the clear and WAS accepted** — it emitted
two words — and it is still correctly exempt, for the reason §8.3 derives: it is
not emitted (no `tlast`), and it may not be attributed to a strobe (REQ-009
licenses none), so §0.6 has no term for it. The machinery is right; the **stated
ground** covers only the never-accepted case and misses the mid-flight
abandonment REQ-009 exists to permit. **The defect is in the specification I
wrote for that monitor, not in the code, which implements what it says.** Exactly
`RV-0067-VERDICT` §6.2's shape, one file over.

**The repair, and it is a re-grounding rather than a rewrite** (the
`J-dv_lead-0113` §9 pattern `WO-0067` §2.1 used at `bench.mli`): keep the
sentence, and add after it, in your own line-wrapping — *a frame the module
accepted and then abandoned mid-flight under `clear` is exempt too, and for a
different reason: it is not emitted, because there is no output `tlast`, and it
cannot be attributed to a strobe, because REQ-009 is the one clause in SPEC-M03
that licenses a frame to vanish without one (§9's own "one real exception"). The
common test is not "was it accepted" but "does §0.6 have a term for it".*

**Do not touch `conservation_monitor.ml`.** Do not add, rename or re-type any
value in the `.mli`.

### 10.2 FINDING K-2 — `split_at_first_tlast`'s documented precondition names two cases and this round makes a third real

The docstring's precondition is about a first frame that delivers **no word**. K2
produces a first frame that delivers **words but no `tlast`** — a case REQ-009
creates and no landed row has ever produced. Under it, `split_at_first_tlast`
returns *all ten* delivered words as its first group and an empty second group,
silently merging A's words into B's; a caller applying the documented
`List.is_empty` guard on each group finds both non-empty and proceeds with a
wrong partition. **This is why §8.4 step 3 partitions by an asserted cycle list
and never calls this function** — and the packet says so in the code, at the
site.

**The repair**: one sentence inside the existing *"The two-group reading's
precondition"* block — *the reading also fails where the first frame delivers
words and never closes: `clear` asserted mid-frame (REQ-009) truncates with no
`tlast`, so the first group returned is the two frames' words concatenated and
the second is empty, and both groups being non-empty is not the guard a caller
needs. Where a frame may deliver without closing, partition by an asserted cycle
set, not by `tlast`.* Cite `WO-0072` §10.2.

### 10.3 OBSERVATION K-O1 — recorded, NOT repaired, and not this round's to change

`Conservation_monitor.frame_out ~aborted` documents `aborted` as *"REQ-007's
`tuser`[0] marking"*. Every landed bad-FCS call site passes `~aborted:false`
while the frame's `tlast` carries `tuser`[0] = 1 (`test_m03_d.ml:171`, on
`WO-0040` §3.1's ground, which argues from the delivered **extent** rather than
from the marking). §7.3 step 7 **copies that call unchanged**, deliberately, so
this round introduces no new inconsistency and no new precedent. Nothing checks
the two monitors' `aborts` counters against each other, so nothing is red today.
**Recorded for the batched `AP-`/machinery round (§18 item 5); not a finding
against this round, not a repair to attempt here, and not a reason to deviate
from family D's landed call.**

---

## 11. The structural witness — one unit, no row id

A repair or a capability with no witness is an unwitnessed edit (`WO-0068` §7.5).
Append **one** `%expect_test` to `test/xgmii_rx_64/test_m03_structural.ml` — the
file whose own docstring says a red there *"is the seam, not a row"*. It drives
no design, needs no bench, and asserts four pure facts about `Bench.Clear`:

```
high_cycles never                          = []
is_ever_high never                         = false
high_cycles (window ~first:6 ~last:10)     = [ 6; 7; 8; 9; 10 ]
value_at (window ~first:6 ~last:10) ~cycle: 5 -> false, 6 -> true,
                                            10 -> true, 11 -> false
```

**The first two lines are the witness that matters**: they are the direct,
mechanical statement that the default schedule's high set is empty, which is what
§5 clause 4's *"enters no new branch"* rests on and is otherwise only an
argument. The third and fourth pin the window's **inclusivity at both ends** —
the one thing about `window` a reader could get wrong.

**Its title carries no `M03-` row id at all**, so the census is unaffected and
only the inventory moves (BOUNCE `BK12` if it names one). Empty `[%expect {||}]`.

**Why not a test that the guard raises.** This suite has no raise-assertion
idiom, and coupling a unit to the guard's message text is what §5 bar B exists to
keep stable. The guard's *walk* is exercised as a non-violation by both K rows;
what the four assertions above cover is the entry condition, which is the part
family J got wrong.

---

## 12. Cost — the size class, measured, and this round's ceiling

`WO-0070`'s cost probe measured family L's stimulus at the throwaway ref:
`T` = **2.036 s** total at `count` = 10 000, driving **105 010** cycles in one
`Bench.run` (`Arrival.cycles` 105 002 + `drain` 8). Band A fired and family L
landed as specified. That is the size class this round is measured against, and
it is measured on **cycles driven**, which is the quantity both packets derive
rather than estimate.

**This round's stimulus, counted from §7.2 and §8.2:**

| unit | runs | cycles per run | elaborations |
|---|---|---|---|
| M03-K1 | 2 (clear + control) | 21 | 2 |
| M03-K2 | 2 (clear + control) | 31 | 2 |
| structural | 0 | 0 | 0 |
| **total** | **4** | — | **4** |

**104 driven cycles and 4 elaborations.** Family L drives **105 010** cycles in a
single unit. `104 / 105 010` = **0.099%** — this round is **three orders of
magnitude inside** the measured class on the derived quantity. **No probe is
required, and `WO-0070` §1.5's band overlap therefore does not need closing in
this packet.**

**The conditional is stated rather than assumed, because the ruling that made it
mine was explicit** (`RV-0070-VERDICT`; affirmed at Q3): *if a round's stimulus
leaves the size class WO-0070 measured, the probe shape is the precedent and
§1.5's band overlap — bands A and B are not a partition, the heap clause appears
in B's trigger and nowhere in A's, with no tie-break — must be closed in the new
packet BEFORE its first run.* This round does not leave the class, so the
overlap is untouched and stays recorded where it is.

**The pre-committed ceiling, so "inside the class" is checkable rather than
asserted**: **total driven cycles across the whole round ≤ 200, total
elaborations ≤ 5.** If your implementation exceeds either, **stop and flag it —
do not improvise a reduction and do not proceed.** Exceeding it means one of
§7.2/§8.2's constants is wrong, which is a finding I want (BOUNCE `BK13`).

---

## 13. Unit structure and scope

### 13.1 Unit structure

**Two `%expect_test` units in one new file `test/xgmii_rx_64/test_m03_k.ml`**, one
per row, plus **one** appended unit in `test_m03_structural.ml`. Each K unit is
its own row's whole stimulus, its own bench, its own control. They share no
`Bench.t` and no schedule.

**Titles — the census reads these, so they are specified rather than left to
taste.** Each must contain its own row id and **no other `M03-` identifier
whatsoever**. In particular **no title may contain `M03-K3`** — it is a
`NO-ASSERT` row and naming it in a title would discharge it in the census exactly
as `M03-A4`'s title does today (which is why the census carries a −1 adjustment
for A4 and would need a second one for K3). Say what you like about K3 in a
comment **after** the `=` line; the census extractor reads from `let%expect_test`
through the `=` line and no further.

Suggested titles, which you may re-word as long as the row id and the derived
content survive:

- `"M03-K1: clear held for five cycles with no frame in flight — the bad-FCS strobe on the preceding cycle does not survive into the window, and the window's five cycles plus the release cycle are silent; a control run at the default schedule shows the delivered stream is unchanged (REQ-009)"`
- `"M03-K2: clear asserted mid-frame and released onto the next frame's start character — the in-flight frame vanishes with two words delivered, no tlast and no strobe, frame_in_exempt accounts it (C-2), and the frame starting on the release cycle is received correctly and completely; a control run at the default schedule proves the schedule carries two well-formed frames (REQ-009)"`

**Expected census and inventory movement, pre-committed:**

| figure | base (`f6a51ce`) | landing | derivation |
|---|---|---|---|
| inventory, `test/xgmii_rx_64/` | **56** | **59** | +2 (K file) +1 (structural) |
| inventory, repository-wide | **136** | **139** | same three |
| census, boundary-matched (row ids named in titles) | **60** | **62** | `M03-K1` and `M03-K2` gained; nothing lost |
| census, naive substring | **60** | **62** | neither K id is a prefix of another row id, so both matchers agree |
| over-discharged set | **{}** | **{}** | unchanged |
| ASSERT rows discharged | **60 of 62** | **62 of 62** | 62 named − 1 (`M03-A4`, NO-ASSERT, named in a title) + 1 (`M03-F5`, discharged by citation) |

**62 of 62 closes the module's ASSERT set with nothing left over.** That figure
is a **title count, not a pass** — quote it with a CI run id beside it or do not
quote it (`RV-0068B-VERDICT` §7's rule, restated because this is the round at
which the number becomes quotable).

### 13.2 The files this round stages — exactly six

| # | path | what moves |
|---|---|---|
| 1 | `test/xgmii_rx_64/bench.mli` | the `Clear` module signature; `?clear` on `run`; `sample`'s `clear` field; the §3 guard paragraph and the §4 `on_clear` sentence in `run`'s docstring; `account_cleared_frame`'s declaration; §10.2's added sentence at `split_at_first_tlast`; the `create` docstring's one clause naming `clear`'s reset cycle as outside every `Clear.t` schedule |
| 2 | `test/xgmii_rx_64/bench.ml` | the `Clear` module; `sample_cycle` drives `i.clear` and records the field; `run`'s `?clear` plumbing, pre-scan guard and `on_clear` feed; `account_cleared_frame` |
| 3 | `test/xgmii_rx_64/test_m03_k.ml` | **NEW**; two units |
| 4 | `test/xgmii_rx_64/test_m03_structural.ml` | **one appended unit** (§11); nothing above it moves |
| 5 | `test/xgmii_rx_64/dune` | **one comment block** added to the standing per-packet row list (a `WO-0072` line naming K1 and K2 ASSERT, K3 NO-ASSERT and not in this round, new file `test_m03_k.ml`). The stanza itself does not move — this library has no `(modules …)` field, so a new `.ml` is picked up with no build change |
| 6 | `test/monitors/conservation_monitor.mli` | §10.1's added sentence inside deviation 3. **Comment-only, in a `.mli`.** Nothing else in `test/monitors/` moves |

Plus this packet's Return log and your own journal entry.

### 13.3 What does NOT move, and that is not a claim that it is correct

`libs/**`, `top/**`, `rtl_snapshots/**`, `docs/**`, `test/attack_plans/**`,
`test/xgmii/**`, `test/monitors/*.ml`, `test/monitors/*.mli` other than file 6,
`tools/**`, and the twelve `test_m03_*.ml` files other than the structural one.
**`test/attack_plans/AP-xgmii_rx_64.md` in particular does not move in this
round** — §7.5's finding, the X-7 row the `Clear` schedule earns, and the
landed-status block for family K are all §18 item 2's, in the batched plan round,
which is the next commit that opens that path. That is a **sequencing** decision,
not a judgement that the plan is currently right.

---

## 14. The review bar — pre-committed, and assigned by seat

**§5.3's rule, applied before this packet issues: every bar below is assigned to
a seat that can execute it.** §17's tool allow-list is tighter than the one that
governed `WO-0071`: the worker now has **no shell at all** beyond
`ocamlc -stop-after parsing`. **Every bar that WO-0071 gave the worker as a
`grep -c` pipeline is therefore either re-expressed as a file-search-and-read bar
or reassigned to me.** That is a consequence of the allow-list, not a change of
standard, and it is stated so the seat map reads as deliberate.

| Bar | Whose | Instrument | Pass condition |
|---|---|---|---|
| **K-1** | **dv** | `git diff f6a51ce <landing>` read **hunk by hunk** | every hunk belongs to one of §13.2's six files and to one of the mechanisms this packet specifies; no seventh file; no hunk in `test/xgmii/**`, `test/monitors/*.ml`, `docs/**`, `libs/**` |
| **K-2** | **dv** | the CI `build` run at the landing commit, **read as a step reading at the source** | step *"Run tests"* and step *"Verify nothing was left unpromoted or non-deterministic"*, each read by name and status. **A badge is not a reading.** A red at *"Run tests"* is routed through §9, never through a re-run |
| **K-3** | **dv** | extract each `%expect_test` unit **body** from every `test/xgmii_rx_64/*.ml` at base and at landing, `diff -r` | the only differing bodies are the two new K units and the one new structural unit. **All 56 landed bodies byte-identical** — the mechanical form of §5 clause 3 |
| **K-4** | **dv** | `tools/dv_checks.sh` at the landing commit, against §13.1's pre-committed table | inventory **56 → 59** and **136 → 139**; census boundary **60 → 62**; census naive **60 → 62**; over-discharged empty at both ends; the gained-row **set difference** is exactly `{M03-K1, M03-K2}` and the lost set is empty. **Measured as a set, not as a difference of totals** (`RV-0071-VERDICT` §1's rule: a difference of totals cannot distinguish "two gained" from "three gained and one lost") |
| **K-5** | **dv** | §7.2's and §8.2's tables, cell by cell, against the landed source, read **against the computing expression and never against a comment** | every derived constant equals the landed assertion. This is the bar `BK2` exists for and it is run by reading (`RV-0071-VERDICT` §2's M-6 discipline) |
| **K-6** | **dv** | line-based string-literal extraction over `test/xgmii_rx_64/**` and `test/monitors/**`, base vs landing | in `test/monitors/**`: **zero** literals differ (file 6 is comment-only). In `test/xgmii_rx_64/**`: every added literal is on §5 bar B's enumerated list; **none removed, none changed** |
| **K-7** | **dv** | `git diff --stat f6a51ce <landing>` | six source paths + this packet + the worker journal; **zero deletions** outside the two docstring sites §10 authorises to gain text (both of which add without deleting) |
| **K-8** | worker | Read `test/xgmii_rx_64/test_m03_k.ml` back in full against §7.2 and §8.2 | every constant in both tables appears as a computed or asserted value at the site the packet places it, and **you report any number of mine you disagree with rather than adopting it** |
| **K-9** | worker | file search for `let%expect_test` across `test/xgmii_rx_64/`, per file, read back | `test_m03_k.ml` **2**, `test_m03_structural.ml` **3**, and each of the other twelve unchanged from the base list in §13.1's derivation. **Report the raw per-file numbers** |
| **K-10** | worker | file search for `[%expect` across `test/xgmii_rx_64/`, then Read each match | every block in the three new units is `{||}`; **zero non-empty blocks anywhere in the directory**. Report the raw counts too — a `[%expect_test]` token inside a comment inflates them (`RV-0068B-VERDICT` §3's artefact) |
| **K-11** | worker | file search for `clear` across `test/xgmii_rx_64/*.ml`, **then Read every hit** | every write of `i.clear` in the directory is inside `Bench.create`'s reset drive or `Bench.sample_cycle`'s choke point — **exactly two sites, and you name them by file and line**. This is a bar about an EXPRESSION and it is executed by reading the hits, never by counting a name (`RV-0068-VERDICT` §9.4) |
| **K-12** | worker | Read `run`'s pre-scan entry condition and `Clear.is_ever_high` back, side by side | the entry condition is `is_ever_high` (or `high_cycles … ≠ []`) and **contains no second predicate reconstructing the high set** — §2's rule, checked at the two lines it governs. **Quote both lines verbatim in your return** |
| **K-13** | worker | Read `sample_cycle`'s body back | the three monitor calls appear in the order `Protocol_monitor.observe`, `Strobe_monitor.sample`, `Protocol_monitor.on_clear`, and `on_clear` is guarded on the driven value (§4.2). **Quote the four lines** |
| **K-14** | worker | Read the two files §10 authorises | both edits are inside a comment or a docstring; **no `val`, `type`, `let` or expression on any changed line** |
| **K-15** | worker | `ocamlc -stop-after parsing` on `bench.ml`, `bench.mli`, `test_m03_k.ml`, `test_m03_structural.ml` | exit 0 for each. **Parse is not the adjudicator; K-2 is** — it establishes syntax and nothing about types, and you should say so rather than let a green parse stand in for a build |
| **K-16** | worker | Read the three new unit titles back in full, and the `=` line after each | each K title contains its own row id and no other `M03-` identifier; the structural title contains none; each `=` is alone on its own line |
| **K-17** | worker | your own journal `Inputs` section, read back | no `libs/**`, no `top/**`, no `rtl_snapshots/**` path |

---

## 15. BOUNCE conditions — pre-committed

- **`BK1` — any unit in `test/**` is red at CI at the landing commit for a reason
  in §9's classes D4a–D4d, or for any reason not in §9's table at all.** General
  by construction. **D1, D2, D3 and D5 are expressly NOT bounces** — they are the
  round working, and they are adjudicated by me, not by the worker.
- **`BK2` — a WRONG ASSERTED VALUE.** Any constant this packet derives at §7.2 or
  §8.2 written into the source with a different value, without the disagreement
  being reported. (`RV-0068-VERDICT` §9.3's repair, carried: the table needs a
  condition for a wrong constant and this is it.)
- **`BK3` — a value ordered checked whose expected value this packet does not
  supply.** If you find one, that is my defect under `RV-0068-VERDICT` §9.2 —
  **report it, do not invent the number.** Reporting it is not a bounce; adopting
  an invented value is.
- **`BK4` — the guard's entry condition is a transition set, or `Clear.never`
  enters the pre-scan.** §2(i).
- **`BK5` — the guard refuses a clear window whose release cycle carries a start
  character.** §2, §3.4(1).
- **`BK6` — the guard reads `Arrival.start_cycles` (or `Arrival` at all) rather
  than the driven word.** §3.3.
- **`BK7` — a row calls `Protocol_monitor.on_clear`.** §4.1.
- **`BK8` — a string literal is removed from or changed in `bench.ml`**, or any
  literal moves in `test/monitors/**`. §5 bar B, K-6.
- **`BK9` — any assertion, comment, docstring, title or Return-log sentence
  claims M03-K1 detects a design that needs a second cycle to settle.** §7.5.
- **`BK10` — either control run is absent**, or its assertions are weaker than
  §7.4 / §8.5 specify.
- **`BK11` — either §10 repair changes one character of executable code.**
- **`BK12` — the structural unit's title names an `M03-` row id**, or either K
  title names a row id other than its own, or any title names `M03-K3`. §11,
  §13.1.
- **`BK13` — the round drives more than 200 cycles or elaborates more than 5
  times.** §12.
- **`BK14` — any file outside §13.2's six appears in your write record**, or any
  of the twelve untouched `test_m03_*.ml` files is modified.
- **`BK15` — `libs/**`, `top/**` or `rtl_snapshots/**` appears in your `Inputs`,
  your Return log or your write record.** PROTOCOL §10.
- **`BK16` — an instrument outside §17's allow-list is used**, or an attempt at
  one is disclosed **only** in chat and not in your journal. §17.

---

## 16. Traps — named so they are not discovered

- **T1 — `split_at_first_tlast` will silently give you the wrong partition in
  K2.** Frame A delivers words and never closes, so the "first tlast" is *B's*,
  and the function returns all ten words as group one. Both groups are non-empty
  in the sense the docstring's guard tests, so the documented guard passes and
  the reading is still wrong. **Partition by §8.4 step 3's asserted cycle list.**
  This is §10.2's finding and the reason it is paid in this commit.
- **T2 — `Frame.sequence_of` raises below 18 octets.** Frame A delivers **16**.
  Call it on B's 60 and on the control run's two 60s; **never on A's prefix**.
- **T3 — asserting the clear window from the schedule you built instead of from
  `s.clear`.** The whole reason the field exists is that a window that landed one
  cycle off is otherwise invisible. §7.3 step 5 and §8.4 step 7 read the sample.
- **T4 — `Clear.high_cycles` and `Strobe_monitor.high_cycles` are different
  functions with different types and unrelated meanings.** The first is the set
  of cycles a clear schedule drives high; the second is a per-strobe count over a
  run. They never appear in the same expression, and confusing them is a type
  error rather than a silent wrong answer — but read the module path before you
  write either.
- **T5 — `account_clean_frame` filters `delivered_samples` over whatever list you
  hand it.** In K2 you must hand it **B's words only**; handing it the whole run
  feeds A's two words into B's latency comparison and produces a wrong `L` for a
  conformant design.
- **T6 — the control run in K2 has A's `tlast` and B's start character on the
  same cycle (11).** That is correct and is not a collision: they are opposite
  directions of the same cycle.
- **T7 — `?clear` must go AFTER `?enable`.** Both are optional labelled
  arguments, so OCaml resolves them by name and the order does not change any
  call site — but the declaration order is what a reader diffs, and this packet
  fixes it so the diff is one insertion.
- **T8 — a bad-FCS frame's `account_clean_frame` takes `~aborted:false` in this
  suite.** It looks wrong against `conservation_monitor.mli`'s own wording. It is
  family D's landed call, §10.3 records why it is not yours to change, and
  changing it here is out of scope.

---

## 17. Your terms — the enumerated tool allow-list, and the two standing clauses

### 17.1 The allow-list — NEW, and this packet is its first carrier

**This is now the standing worker-dispatch form, and it is written into the
packet so that packet and dispatch agree.** Your permitted instruments are, in
full:

1. **File read** — reading any file in the repository, and file/content search
   over it (the Read, Grep and Glob tools).
2. **File edit and write** — **only** at the six paths §13.2 names, plus this
   packet's Return log, plus your own journal at
   `agents/journals/workers/claude_tb_writer_agent*.md`.
3. **`ocamlc -stop-after parsing`** on the OCaml files you wrote.

**Everything else is forbidden**: `git` (every subcommand, including read-only
ones such as `status`, `diff`, `show` and `log`), `dune` (every subcommand,
ADR-0005), the network in every form, and **any other shell command whatsoever**
— including `grep`, `sed`, `awk`, `cat`, `find`, `ls` and `wc`. Where §14 gives
you a bar phrased as a search, execute it with the file-search tool and by
reading the hits, never with a shell pipeline.

**Flag, do not improvise.** If a bar in §14 appears to you to need an instrument
outside this list, **stop and say so in your return and in your journal**. Do not
find a way around it, and do not substitute a weaker instrument silently. A bar
that cannot be executed at your seat is my defect, and it is one I want reported.

### 17.2 The durability clause — a return demand

**If you attempt an instrument outside your seat and are refused — by the
environment, by a permission prompt, or by your own judgement mid-command — that
attempt goes into your JOURNAL** (Evidence or Open-questions), not only into your
return message. A disclosure that lives only in chat does not survive the session:
`RV-0071-VERDICT` §3 had to withdraw a claim precisely because the previous
round's disclosure was chat-only and the evidence was unrecoverable. **Disclosure
is credited in full either way**; the point is that the credit must be readable
from the repo.

### 17.3 The substitution clause

You cannot enumerate your own staged set and **must not reach for `git status` to
try**. Your instrument for the files-list obligation (PROTOCOL §4.2, and §19 item
5 below) is **your own record of what you wrote, with §13.2's list as the
authority**. That is the sanctioned substitute, it is sufficient, and it is not a
second-best. Likewise you cannot compare against the base tree: **every base-side
figure any bar needs is pre-committed in this packet** (§13.1's table), so you
check against this packet and never against history.

### 17.4 Sequencing — ONE worker round, and the internal order

**One round, one worker, one commit.** The capability, its guard and its two
consumers land together, on `WO-0067`'s precedent and `WO-0068` §7.4's ground: a
commit that makes a capability reachable and leaves its guard or its consumers
for a later round has shipped a window in which the hole is live, and there is no
later round here to close it. The one thing that **is** staged is the ordering
inside the round, so that stopping early stops at a coherent point:

1. `Clear` in `bench.mli` / `bench.ml`, and `run`'s plumbing, guard and
   `on_clear` feed.
2. The structural witness (§11) — the capability's witness before its consumers.
3. `account_cleared_frame` (§8.3).
4. `test_m03_k.ml`: M03-K1 and its control.
5. `test_m03_k.ml`: M03-K2 and its control.
6. The two comment-only re-groundings (§10.1, §10.2).
7. The `dune` header line.

---

## 18. What this round does NOT close, and what I owe after it

1. **No `SO-xgmii_rx_64.md` is opened or offered by this round**, and the census
   reaching 62 of 62 does not open it. Outstanding before any PASS: the family L
   and family M **mutation campaigns**, PROTOCOL §10-sequenced after
   `RV-0071-VERDICT`'s ACCEPT and before any `SO-` PASS; family J and family K
   unscored; and the charter §3 **verilog-ethernet differential co-sim anchor**,
   undischarged.
2. **The batched `AP-` round is mine and is the next commit that opens
   `test/attack_plans/**`.** It now carries, on top of `RV-0071-VERDICT` §7 item
   2's list: **(a)** §7.5's M03-K1 Kills-cell finding, with the sixth-instance
   disposition beside it; **(b)** an **X-7** row for the `Clear` schedule on the
   X-4/X-6 precedent, recording that the constraint is the deliverable as much as
   the schedule is, and that its subject and entry condition were re-derived
   rather than transplanted (§2); **(c)** a landed-status block for §4.K with its
   SHA and CI run id; **(d)** §8.6's reclassification of K2's third kill from
   design-kill to monitor-precondition; **(e)** §7's *"Not gaps"* dated note
   gaining the date at which *"used by M03-J1 and M03-K2"* became true of K2.
3. **`M03-K3` stays `NO-ASSERT`** and this round makes no claim about it. The
   protocol monitor's frame-in-progress reset is *machinery this round wires*
   (§4), not a design assertion, and the census must not record K3 as discharged.
4. **The §3.2 spec ambiguity** — §6.2's `Idle` row transition column against §7's
   *"state `Idle`"* on a clear cycle — is recorded for the next spec queue with
   architect_docs_lead. Non-blocking: the guard removes any need for a ruling
   before this round lands.
5. **OBSERVATION K-O1** (§10.3) rides to the same batched round.
6. **OBSERVATION M-O1, FINDING M-1/M-2 and OBSERVATION L-O1** remain exactly
   where `RV-0071-VERDICT` §11 left them.

---

## 19. Your return

Append a `### RETURN — tb_writer, spawn <short-id>` section to this packet's
Return log carrying, in this order:

1. **What you built**, file by file, against §13.2's six.
2. **Every bar in §14 marked *worker*, with its raw output or the exact lines you
   read** — K-8 through K-17. Quote, do not summarise, where the bar says
   *quote*.
3. **Every constant of §7.2 and §8.2 you checked, and every one you disagree
   with.** A disagreement with any number of mine is a finding I want, and the
   last four rounds were each decided by a defect in my instructions rather than
   in the work. **Do not adopt a number of mine you cannot derive; report it.**
4. **The three quoted code readings** K-12 and K-13 demand, verbatim.
5. **Your files list**, from your own write record with §13.2 as the authority
   (§17.3), and your journal entry id.
6. **Any instrument you attempted outside §17.1's list, and its outcome** — in
   your journal as well as here (§17.2).
7. **Anything in this packet you could not execute as written.**

**What you do not do**: run `dune`; run `git`; touch a seventh file; adjust a
constant to make something agree; claim anything §7.5 forbids; or judge whether
K1 or K2 will pass. The verdict is CI's and the adjudication is mine.

---

## Return / verdict log

*(empty at issue — participants append here, PROTOCOL §3)*

---

### RETURN — tb_writer, spawn `WO-0072-B/2026-08-09T18:20Z`

#### 1. What I built, against §13.2's six

1. `test/xgmii_rx_64/bench.mli` — the `Clear` module signature (`never`,
   `window`, `value_at`, `high_cycles`, `is_ever_high`, `report`), placed
   after `Enable`'s `end`; `run`'s `?clear:Clear.t` argument (after
   `?enable`, before the terminal `unit`) with a new "The K guard" doc
   section; `sample`'s `clear` field (after `enable`); the on-clear sentence
   folded into the (a)/(b)/(c)/(d) list in `run`'s own docstring;
   `account_cleared_frame`'s declaration (placed after
   `account_dropped_piece`, before `split_at_first_tlast`); §10.2's added
   paragraph at `split_at_first_tlast`'s docstring; `create`'s docstring
   gains one clause naming `clear`'s reset cycle as outside every `Clear.t`
   schedule.
2. `test/xgmii_rx_64/bench.ml` — the `Clear` module (implemented as a plain
   `{ first; last }` record, `last < first` encoding `never`); `sample`'s
   `clear` field; `sample_cycle` gains a `~clear` parameter, drives
   `i.clear` at the same choke point as `i.cfg_rx_enable`, and feeds
   `Protocol_monitor.on_clear` last, guarded on the driven boolean;
   `run` gains `?clear`, resolves its default to `Clear.never`, and runs
   the K guard (§3) after the M03-J4 guard and before the drive loop;
   `account_cleared_frame`'s implementation (placed after
   `account_dropped_piece`, before `split_at_first_tlast`).
3. `test/xgmii_rx_64/test_m03_k.ml` — **NEW**. Two `%expect_test` units:
   M03-K1 (`run_k1`, plus its mandatory control run) and M03-K2 (`run_k2`,
   plus its mandatory control run). One shared helper,
   `assert_delivered_words`, factors the per-word cycle/tkeep/tlast/tuser
   check both rows' own clean 8-word frames need (K1's bad-FCS frame in
   both its runs, K2's frame B in both its runs).
4. `test/xgmii_rx_64/test_m03_structural.ml` — one appended unit (§11): four
   pure facts about `Bench.Clear` (`high_cycles never = []`,
   `is_ever_high never = false`, `high_cycles (window ~first:6 ~last:10) =
   [6;7;8;9;10]`, `value_at` at cycles 5/6/10/11), empty `[%expect {||}]`,
   title carries no `M03-` id. Nothing above it in the file moved.
5. `test/xgmii_rx_64/dune` — one comment block appended to the standing
   per-packet header list, naming K1/K2 ASSERT, K3 NO-ASSERT and not in
   this round, new file `test_m03_k.ml`. The stanza itself is untouched.
6. `test/monitors/conservation_monitor.mli` — one paragraph appended inside
   deviation 3, extending the stated ground to the mid-flight-abandonment
   case (§10.1, FINDING K-1). Comment-only; nothing else in `test/monitors/`
   moved.

Plus this Return log and my journal entry `J-tb_writer-0031`.

#### 2. Worker bars K-8 … K-17

**K-8** — Read `test_m03_k.ml` back in full against §7.2 and §8.2. Every
constant in both tables appears as a computed or asserted value at the site
the packet places it (details in item 3 below). No disagreement found on
any of the 25 (§7.2) or 30 (§8.2) numbered cells I could map to an
assertion. Two cells — §7.2 item 24 and §8.2 item 28
(`Latency.observed`'s per-class front-offset/L breakdown) — are **not**
directly asserted in either row, because both rows' own ordered assertion
lists (§7.3 step 8: "Item 22, item 23's five counters, item 25"; §8.4 step
10: "Items 25, 26, 27's five counters, item 29") skip from the item before
to `Latency.word_delay`, omitting an explicit check of item 24/28 itself. I
followed the ordered list literally rather than adding an assertion it does
not call for — see Open-question 1.

**K-9** — file search for `let%expect_test` across `test/xgmii_rx_64/`, per
file, raw counts:
```
test_m03_a.ml: 3    test_m03_b.ml: 7    test_m03_c.ml: 4
test_m03_d.ml: 3    test_m03_e.ml: 4    test_m03_f.ml: 4
test_m03_g.ml: 7    test_m03_h.ml: 4    test_m03_i.ml: 5
test_m03_j.ml: 3    test_m03_k.ml: 2    test_m03_l.ml: 2
test_m03_n.ml: 8    test_m03_structural.ml: 3
```
`test_m03_k.ml` = 2, `test_m03_structural.ml` = 3 (was 2, +1); every other
twelve file's count is unchanged from the base list §13.1 derives (total
59, up from 56 at base — matches +2 (K file) +1 (structural)).

**K-10** — file search for `[%expect` across `test/xgmii_rx_64/`, then read
every match. Raw counts per file (this pattern also matches the substring
`[%expect_test]`, which is the artefact `RV-0068B-VERDICT` §3 names):
```
test_m03_a.ml: 3    test_m03_b.ml: 7    test_m03_c.ml: 4
test_m03_d.ml: 3    test_m03_e.ml: 4    test_m03_f.ml: 4
test_m03_g.ml: 7    test_m03_h.ml: 4    test_m03_i.ml: 5
test_m03_j.ml: 3    test_m03_k.ml: 2    test_m03_l.ml: 2
test_m03_n.ml: 8    test_m03_structural.ml: 4  <- includes the artefact
```
The `test_m03_structural.ml` figure of 4 against `let%expect_test`'s 3 is
exactly the artefact: line 22 of that file is the pre-existing sentence
"These bindings are never called from any `[%expect_test]` — they are
witnessed by compiling at all", inside a doc comment I did not touch. Every
block in the three new units this round adds — both of `test_m03_k.ml`'s
and the one appended to `test_m03_structural.ml` — is `{||}`, verified by
reading each. **Finding, not resolved**: `test_m03_i.ml:1796` carries a
pre-existing, non-empty, promoted `[%expect {| … |}]` block (M03-I4),
predating this round entirely and untouched by it. Bar K-10's literal pass
condition — "zero non-empty blocks anywhere in the directory" — does not
hold against the base tree because of it. I read the bar as "zero non-empty
blocks ADDED this round" and satisfied that reading; see Open-question 2.

**K-11** — file search for `clear` / `i\.clear` across
`test/xgmii_rx_64/*.ml`, every hit read. Every write of `i.clear` in the
directory is at exactly two sites (by function, as the bar's own wording
groups them):
```
bench.ml:65:  i.clear := Bits.vdd;
bench.ml:68:  i.clear := Bits.gnd;
```
— both inside `Bench.create`'s reset drive (pre-existing, unchanged by this
round — `create`'s own body was already asserting then releasing `clear`
through the reset cycle before WO-0072), and
```
bench.ml:267:  i.clear := if clear then Bits.vdd else Bits.gnd;
```
— inside `Bench.sample_cycle`'s choke point (this round's own addition).
Every other `.clear` hit in `test/xgmii_rx_64/*.ml` is a *read* of
`s.clear` in `test_m03_k.ml` (T3's own instrument, five hits: lines 256,
264, 504, 512, and the comment naming it at 252) — no other write site
exists.

**K-12** — `run`'s pre-scan entry condition and `Clear.is_ever_high`, read
back side by side and quoted verbatim:
```
bench.ml:387:  (match Clear.is_ever_high clear with
bench.ml:186:  let is_ever_high t = not (List.is_empty (high_cycles t))
```
The entry condition is `Clear.is_ever_high clear`, which is exactly the
projection at line 186 — `not (List.is_empty (high_cycles t))` — and
contains no second predicate reconstructing the high set.

**K-13** — `sample_cycle`'s body, read back; the three monitor calls in
order plus the return record showing `clear` threaded, quoted verbatim:
```
bench.ml:300:  Protocol_monitor.observe t.protocol ~cycle out;
bench.ml:301:  Strobe_monitor.sample t.strobes ~cycle ~high:errors_high;
bench.ml:308:  if clear then Protocol_monitor.on_clear t.protocol ~cycle;
bench.ml:309:  { cycle; in_word; enable; clear; out; after_out; errors_high }
```
Order is `observe`, `sample`, `on_clear`; `on_clear` is guarded on the
driven `clear` boolean (line 308's own `if clear then …`), never called
unconditionally.

**K-14** — the two files §10 authorises, read back. Both edits sit entirely
inside `(** … *)` comment blocks:
`conservation_monitor.mli` lines 46–53 (the new deviation-3 paragraph) and
`bench.mli` lines 623–628 (the new `split_at_first_tlast` paragraph). No
`val`, `type`, `let` or expression appears on any changed line in either
file — confirmed by reading both ranges back after the edit.

**K-15** — `ocamlc -stop-after parsing` on the four touched/new files, run
twice (once mid-round, once after the journal write, to catch any
accidental disturbance from the later edit):
```
$ ocamlc -stop-after parsing test/xgmii_rx_64/bench.mli   ; EXIT:0
$ ocamlc -stop-after parsing test/xgmii_rx_64/bench.ml     ; EXIT:0
$ ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_k.ml            ; EXIT:0
$ ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_structural.ml   ; EXIT:0
```
Parse is not the adjudicator — this establishes syntax only, nothing about
types, and K-2 (the CI `build` run) is dv's own bar, not mine.

**K-16** — the three new unit titles, read back in full, and the `=` line
after each:
- `test_m03_k.ml:361-365`: `"M03-K1: clear held for five cycles with no
  frame in flight -- the bad-FCS strobe on the preceding cycle does not
  survive into the window, and the window's five cycles plus the release
  cycle are silent; a control run at the default schedule shows the
  delivered stream is unchanged (REQ-009)"`, `=` alone on line 366. Contains
  `M03-K1` and no other `M03-` id.
- `test_m03_k.ml:627-632`: `"M03-K2: clear asserted mid-frame and released
  onto the next frame's start character -- the in-flight frame vanishes
  with two words delivered, no tlast and no strobe, frame_in_exempt
  accounts it (C-2), and the frame starting on the release cycle is
  received correctly and completely; a control run at the default schedule
  proves the schedule carries two well-formed frames (REQ-009)"`, `=` alone
  on line 633. Contains `M03-K2` and no other `M03-` id.
- `test_m03_structural.ml:111-112`: `"Bench.Clear: the default schedule's
  high set is empty, and window is inclusive at both ends (WO-0072 section
  11)"`, `=` alone on line 113. Contains no `M03-` id at all.

**K-17** — my own journal `Inputs` section, read back: lists
`docs/specs/modules/xgmii_rx_64.md`, `docs/specs/requirements.md`,
`test/attack_plans/AP-xgmii_rx_64.md`, `test/xgmii_rx_64/bench.mli`,
`test/xgmii/{arrival,frame,xgmii_word}.mli`,
`test/monitors/{conservation,protocol,strobe}_monitor.mli`, `octet_time.mli`,
`stream_word.mli`, `test/xgmii_rx_64/{test_m03_d,test_m03_j,
test_m03_structural}.ml` (convention only), `test/xgmii_rx_64/dune`, and this
work order. No `libs/**`, `top/**` or `rtl_snapshots/**` path appears.

#### 3. Constants checked against §7.2 and §8.2

**§7.2 (M03-K1), items 1–23, 25** — all checked against the landed source
and all agree with the packet: frame count 1; `start_octet_time` 8;
`start_lane` 0; `start_cycle` 1; `terminate_octet_time` 80; terminate cycle
10; `Arrival.cycles` 13; cycles driven 21; sample count 21 (both implicit in
`~drain:8` and unchecked as a bare count, but the underlying `total` these
derive from was independently confirmed via `Arrival.cycles` = 13); 60
delivered octets; 8 output words; delivered cycles `[4;5;6;7;8;9;10;11]`;
tlast cycle 11; tkeep 0xFF ×7 then 0x0F; tuser 1 on tlast; `error_pulses`
exactly `[(11, "error_bad_fcs")]`; `Strobe_monitor.expect` event (cycle 11,
not_before 10, not_after 13, frame 0); delivered octets =
`Frame.delivered bad`; clear window 12..16; release cycle 17; `s.clear`
predicate `12 <= cycle <= 16`; `cleared_mid_frame` 0; conservation five
counters (1/1/0/0/0); `Latency.word_delay` `Some 3`. **Item 24
(`Latency.observed`) not directly asserted — see item 1/Open-question 1.**
No disagreement on any checked cell.

**§8.2 (M03-K2), items 1–27, 29** — all checked and all agree: frames in
schedule 2; A start_octet_time/lane/cycle 8/0/1; A terminate_octet_time/
cycle 80/10; B start_octet_time/lane/cycle 92/4/11 (the number the whole
row rests on, checked and separately flagged); B terminate_octet_time/cycle
164/20; `start_spacings` `[10]`; `gaps` `[12]`; `Arrival.cycles` 23; clear
window 6..10; release cycle 11 (= B's own start cycle); A's would-be words
at `[4;5;6;7;8;9;10;11]`; A's delivered words WITH clear = exactly 2, at
cycles 4 and 5; A's delivered tkeep 0xFF both; A's delivered octet count
16; A's delivered octets = first 16 of `Frame.delivered a`; A's tlast none
anywhere; B's delivered words 8, at cycles 14..21; B's tlast cycle/tkeep/
tuser 21/0x0F/0; B's delivered octets = `Frame.delivered b`, 60 octets;
`sequence_of` of B's delivered octets 1; the run's complete delivered-cycle
list `[4;5;14;15;16;17;18;19;20;21]`; `error_pulses` `[]`; `s.clear`
predicate `6 <= cycle <= 10`; `cleared_mid_frame` 1; `frames`/`words`/
`aborts` 1/10/0; conservation five counters (1/1/1/0/0);
`Latency.word_delay` `Some 3`. **Item 28 (`Latency.observed`) not directly
asserted — see item 1/Open-question 1.**

**No disagreement with any number in §6, §7.2 or §8.2 was found.** Every
cell I could independently re-derive from `Arrival`'s own arithmetic (§6's
own layout: `ifg=12`, `first_start=8`) agreed with the packet's printed
value.

#### 4. The three quoted code readings (K-12, K-13)

Reproduced verbatim from item 2 above:
```
bench.ml:387:  (match Clear.is_ever_high clear with
bench.ml:186:  let is_ever_high t = not (List.is_empty (high_cycles t))
bench.ml:300:  Protocol_monitor.observe t.protocol ~cycle out;
bench.ml:301:  Strobe_monitor.sample t.strobes ~cycle ~high:errors_high;
bench.ml:308:  if clear then Protocol_monitor.on_clear t.protocol ~cycle;
```

#### 5. Files list and journal entry id

From my own write record, §13.2 as authority (§17.3):
- `test/xgmii_rx_64/bench.mli`
- `test/xgmii_rx_64/bench.ml`
- `test/xgmii_rx_64/test_m03_k.ml` (new)
- `test/xgmii_rx_64/test_m03_structural.ml`
- `test/xgmii_rx_64/dune`
- `test/monitors/conservation_monitor.mli`
- this packet's Return log (`agents/handoffs/WO-0072_m03-family-k-clear.md`)

Journal entry: `J-tb_writer-0031`, appended to
`agents/journals/workers/claude_tb_writer_agent.v02.md`, `task:WO-0072`,
Trigger carries spawn short-id `WO-0072-B/2026-08-09T18:20Z`.

#### 6. Instruments attempted outside §17.1's list

None. Every instrument used was file read/search (Read, Grep, Glob) within
the six staged paths plus this packet plus my journal, or
`ocamlc -stop-after parsing` on the four `.ml`/`.mli` files I wrote. No
`git`, no `dune`, no network call, no other shell command was attempted at
any point — nothing to journal under the durability clause (§17.2) because
nothing was refused. (One tool-level hiccup occurred mid-round — the Bash
tool itself returned "temporarily unavailable" twice for unrelated
environment reasons before the `ocamlc` calls succeeded; this is an
environment transient, not a refused-instrument event, and both retries
used the same permitted `ocamlc -stop-after parsing` command with no
substitution.)

#### 7. What I could not execute as written

Nothing in this packet was unexecutable as written. Two items are recorded
as open questions rather than defects because I could not tell, from the
packet's own text, whether a literal reading (item 24/28 unasserted; K-10's
"zero non-empty blocks" against a tree that already has one) was intended
or an oversight — see Open-questions below, which restates them for the
record.

#### Open questions for dv_lead

1. **§7.2 item 24 / §8.2 item 28 (`Latency.observed`'s per-class
   front-offset/L breakdown).** Both rows' own ordered assertion lists
   (§7.3 step 8, §8.4 step 10) skip this item and go straight to
   `Latency.word_delay`. I did not add an explicit `Latency.observed` check
   in either row, reading the omission as deliberate (a "carried" figure,
   in the sense §7.3's own note on M03-D1 uses the word). Please confirm
   whether that reading is correct or whether a future round should add the
   explicit check.
2. **Bar K-10's literal pass condition** ("zero non-empty blocks anywhere
   in the directory") does not hold against the base tree —
   `test_m03_i.ml:1796` carries a pre-existing, non-empty, promoted
   `[%expect]` block from M03-I4, untouched by and predating this round. I
   executed the bar under the reading "zero non-empty blocks ADDED this
   round," which holds. Flagging the literal/tree mismatch per §17.3's
   stop-on-inconsistency clause rather than resolving it myself.
3. No RTL leak, no licensing concern, no untestable requirement, no spec
   ambiguity beyond the one §3.2 already resolves for me (the guard removes
   any need for a ruling before this round lands, per the packet's own
   text) — nothing further to escalate.
