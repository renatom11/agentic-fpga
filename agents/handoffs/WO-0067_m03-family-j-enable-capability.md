# WO-0067: the `cfg_rx_enable` schedule — family J's missing bench capability, and the three rows it makes writable

- **State**: **DRAFT** (the id is the orchestrator's to allocate at first
  commit, PROTOCOL §3; `0067` is this packet's placeholder and its expected
  allocation). A live field, updated clerically; nothing else in this packet's
  body is ever amended in place.
- **From** / **To**: dv_lead → **tb_writer**, via the orchestrator.
- **Round class**: bench **capability** + the rows the capability makes
  immediately writable. Not a refactor, not a campaign, no seal.
- **Spec basis**: `docs/specs/requirements.md` **REQ-810** (both normative
  clauses and its verification column), **REQ-803**, **REQ-802**, **§0.6**
  (the conservation equation and the strobe window), §0.7, §12;
  `docs/specs/modules/xgmii_rx_64.md` **§4.3** (all of it — the three-clause
  admission statement), **§6.1**'s *"When `cfg_rx_enable` is 0"* paragraph,
  **§6.2**'s `Idle`/`Preamble`/`Frame` rows, **§6.3 item 7**, **§7**'s
  configuration-sampling bullet, **§9**'s closure-list clause (b), **§10**'s
  REQ-802/REQ-810 hook. **ADR-0014** (`docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`)
  in full — it is the ruling every row below stands on.
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` **§4.J** rows
  **M03-J1**, **M03-J2**, **M03-J3**, **M03-J4**; §4.N row **M03-N4**; §7's
  machinery table; §8 item 3.
- **Independence (PROTOCOL §10)**: do **not** open
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, any other `libs/**` path, or
  `rtl_snapshots/**`. Your journal `Inputs` section is the standing evidence
  that you did not. Every number in this packet is derived from the
  specification, from `test/xgmii/**` and from `test/xgmii_rx_64/bench.mli`; if
  one is wrong it is wrong for a reason findable in those three places, and
  §9's bar is that you **check the derivations rather than take them**.
- **You cannot run the simulation** (ADR-0005): `dune build` / `dune runtest`
  are CI's, not this seat's. `ocamlc -stop-after parsing` is available and is
  bar 6. Every cycle number below is therefore **derived and owed a check by
  arithmetic**, not by a run, and CI at the landing commit is the adjudicator.

---

## 0. What this round is, in one paragraph

`test/xgmii_rx_64/bench.mli`'s `create` drives `cfg_rx_enable` to 1 before the
reset cycle and never touches it again, and its own docstring says so: *"release
`clear` after one cycle and hold `cfg_rx_enable` at 1 for the rest of the run —
family J (the disable path) is out of this packet's eleven rows"*. That
sentence has been true for forty-eight landed units and it is why family J has
been deferred twice. This round ends that. It adds **one capability** — a
per-cycle `cfg_rx_enable` schedule, driven through the same choke point the
XGMII word is driven through — and writes the **three family-J rows** the
capability makes immediately writable (**M03-J1**, **M03-J2**, **M03-J3**). It
also pays one parked documentation debt that rides this round because this round
opens the file that carries it. **M03-N4 is deliberately not in this round**;
§8 says why, in terms, and dates it.

---

## 1. The capability — its shape, and why the three losing shapes lose

### 1.1 What the stimulus actually requires, derived from the four rows

Read the four §4.J stimulus cells and M03-N4's together and they impose exactly
five requirements. Nothing below is a preference; each is a cell's own words.

- **(R-a) A value on every driven cycle, drain included.** M03-J1 holds the
  enable at 0 across a hundred frames; M03-N4 holds it at 0 across an in-flight
  frame's completion *and* into the next frame's admission. There is no cycle of
  a family-J run on which the enable is "don't care".
- **(R-b) Change cycles derived from the schedule, never hand-counted.**
  M03-J2: *"0 → 1 **at least one cycle before a start character**"*. M03-J3:
  *"1 → 0 **mid-frame**, at least one cycle away from any start character"*. Both
  are stated relative to events the `Arrival` schedule owns.
- **(R-c) A refusal of M03-J4's placement, checked against the words AS DRIVEN.**
  M03-J4 is `NO-STIMULUS`: *"A change landing on the **exact cycle** of a start
  character has no determinate outcome and **SHALL NOT** be driven-and-asserted"*
  — SPEC-M03 §6.3 item 7, carry-forward **C-14.5**. The decisive detail: at
  M03-N4 the start character that matters is **injected** by
  `Dv_xgmii.Injection` and reaches the DUT through `run`'s `?word_at` override.
  It is **not** in the `Arrival` schedule at all. A guard that reads start
  cycles from `Arrival` is therefore blind at the one row whose start character
  is the whole point, and would report "clean" on the stimulus it exists to
  refuse.
- **(R-d) The default must be today's behaviour, exactly.** Forty-eight units
  are landed against `cfg_rx_enable` = 1 for the whole run.
- **(R-e) It is driven at the choke point.** `sample_cycle` is *"the one
  function that touches the design"* (RV-0038-R5 / R5-1) and the ordering guard
  lives there because of it. A second port driven anywhere else would be a
  second place that touches the design.

### 1.2 The shape — an `Enable` schedule declared in `bench.mli`, consumed by `run`

**This is what you build.** In `test/xgmii_rx_64/bench.mli` and `bench.ml`:

```ocaml
(** A [cfg_rx_enable] schedule: the value in force from cycle 0, and the cycles
    at which it changes. The reset cycle {!create} drives is outside every
    schedule and is not governed by this type — see {!create}. *)
module Enable : sig
  type t

  (** 1 for the whole run. The DEFAULT, and byte-for-byte the behaviour every
      unit landed before WO-0067 was written against. *)
  val high : t

  (** 0 for the whole run — M03-J1's own stimulus before its re-enable. *)
  val low : t

  (** [changes ~initial cs] — [initial] from cycle 0, then the value of each
      [(cycle, value)] of [cs] from that cycle inclusive. Cycles must be
      strictly ascending and positive; a repeated or descending cycle, or a
      change to the value already in force, raises at construction, because a
      schedule that says nothing at a cycle it names is a schedule its author
      did not mean. *)
  val changes : initial:bool -> (int * bool) list -> t

  (** The value driven on [cycle]. Total, like [Arrival.word_at]. *)
  val value_at : t -> cycle:int -> bool

  (** The cycles at which the driven value differs from the previous cycle's,
      with the value taken. [high] and [low] both return []. *)
  val change_cycles : t -> (int * bool) list

  (** Deterministic summary for an expect block: the initial value and every
      change. *)
  val report : t -> string
end
```

and `run` gains **one optional argument, placed before its terminal `unit`**:

```ocaml
val run
  :  t
  -> Dv_xgmii.Arrival.t
  -> drain:int
  -> ?word_at:(cycle:int -> Dv_xgmii.Xgmii_word.t)
  -> ?enable:Enable.t          (* NEW; defaults to [Enable.high] *)
  -> unit
  -> sample list
```

and `sample` gains **one field**:

```ocaml
type sample =
  { cycle : int
  ; in_word : Dv_xgmii.Xgmii_word.t
  ; enable : bool               (* NEW *)
  ; out : Dv_monitors.Stream_word.t
  ; after_out : Dv_monitors.Stream_word.t
  ; errors_high : string list
  }
```

**Why `enable` belongs in `sample`, derived and not decorative.** `sample`
already carries `in_word` — the stimulus as driven — for one reason: a row
proves its stimulus landed where it intended rather than asserting from memory
of the argument it passed (M03-I2 member (iii)'s *"construction and landing
checked at both sites"*). `cfg_rx_enable` is the same object one port over: it
is a driven input, sampled by the design on the same cycle under the same
`Before` convention, and it needs the same one cycle label. Without it, a row
whose change landed one cycle early has no instrument that can say so — see
trap **T2**.

### 1.3 The three losing shapes, and the defect that loses each one

**(a) A `create` parameter — `val create : ?cfg_rx_enable:… -> unit -> t`.**
This is the shape the current docstring invites, because `create` is where the
enable is driven today. It loses on **(R-c)**, decisively, and on **(R-b)**
before that.

- `create` never sees a schedule and never sees a driven word. M03-J4's
  constraint is a statement about the *coincidence* of an enable change with a
  start character, so it cannot be checked at `create` at all. The check would
  have to live in `run` regardless — and a capability whose constraint is
  enforced somewhere other than where it is declared is precisely the shape
  `idle_injection.mli` refused: *"That is a constraint on this file, not on any
  design, and it is enforced here rather than left to each bench."*
- The changes M03-J2 and M03-J3 need are stated relative to `Arrival`'s own
  start cycles, and `create` is called on the other side of the schedule at
  several existing sites. A create-time parameter puts the stimulus's most
  error-prone number one call away from the only object that can derive it.
- Third, and smaller: `create`'s body is this file's statement of the
  **invariant** wiring — the reset, the three standing monitors, the tagger's
  four constants. The enable is now the *variable* part of the stimulus. Mixing
  them makes `cfg_rx_enable` the only stimulus in this bench not passed to
  `run`.

**(b) A separate stimulus module under `test/xgmii/`, on the `Idle_injection`
model.** Superficially the strongest analogy — and it is the wrong directory,
for a reason ADR-0014 itself supplies. Everything in `test/xgmii/` is the
**link partner and the wire**: `Arrival` is REQ-018's arrival scheduler,
`Injection` is error injection *on the wire*, `Idle_injection` is REQ-016's idle
insertion *between wire words*, `Xgmii_word` is the wire. `cfg_rx_enable` is
**not on the wire**: it is a configuration input of the DUT (SPEC-M03 §4.3,
REQ-802's configuration record), and the whole content of ADR-0014 is that the
enable does not reach the wire — *"it does not blind the module to the lane
pair, and it cannot"*. Homing the enable in the link-partner library would
state, in the directory structure, the reading ADR-0014 rejected. It also fails
**(R-c)** for the same reason (a) does: such a module knows nothing about the
words `run` drives. Its *lesson* is kept in full — the constraint is the
deliverable as much as the capability is (§3).

**(c) A mutable setter plus segmented runs — `set_enable t v` between two `run`
calls.** This is the shape a reader reaches for first, and it is the one that
costs the most. `run` always drives from cycle 0, and `sample_cycle`'s
choke-point guard is `if cycle <> t.cycles_driven then failwith …`, so a second
`run` against the same `t` raises on its first cycle. Making this shape work
means either deleting the ordering guard that caught run `30771064764`'s
reversed drive, or giving `run` a start-cycle parameter — a change to the one
function that touches the design, made for a stimulus's convenience. It
additionally breaks the cycle label: the `Protocol_monitor` and `Strobe_monitor`
are fed `~cycle` from `run`'s own counter, and two segments would either restart
that counter or need it threaded, which is the second true statement about
ordering this file deliberately does not have. **Rejected, and named here so it
is not re-invented in the Return log.**

**(d) A bare closure — `?enable_at:(cycle:int -> bool)`, mirroring `?word_at`
exactly.** This one nearly wins, and it is worth saying precisely why it does
not. It satisfies (R-a), (R-d) and (R-e), and even (R-c) is implementable
against it (`run` can detect a change by comparing consecutive evaluations). It
loses on two counts. First, **(R-b)**: five call sites each hand-writing
`fun ~cycle -> cycle >= k` with five hand-computed `k`s is the duplicated idiom
with an unstated precondition that this programme has now paid for twice —
`RV-0057-VERDICT` Finding 1 and `RV-0062` FINDING B-1, the two incidents WO-0064
existed to close. The one quantity every family-J row must get right is an
off-by-one against a start cycle, and a closure gives the five sites nothing
shared to get it right in. Second, a closure has no `report`: the J-rows'
expect blocks need to show the window they drove, and an opaque function cannot
be printed. `Enable.t` is the same closure with a name, a construction check and
a rendering — which is exactly what `Arrival.t` is to a list of words.

### 1.4 One detail of the chosen shape, stated so it is not decided by accident

`create` keeps driving `cfg_rx_enable` = 1 through its reset cycle, **unchanged**
(§2's bar depends on it). That cycle is outside every schedule — `bench.mli`
already says so of `Arrival.check`, in the `create` comment in `bench.ml`
(*"standing obligation 5 (Arrival.check) never reaches this cycle because it is
outside every schedule"*) — and it is REQ-009's cycle, not REQ-810's. The
`Enable.t` schedule governs from **cycle 0** of `run`. Where a schedule's
`initial` is `false` there is therefore a 1 → 0 transition between the reset
cycle and cycle 0, and the M03-J4 guard **checks it like any other change**,
with the pre-run value taken as `true` because that is what `create` drove. In
this suite it always passes: `frames_at` fixes `first_start` at 8 or 12, so the
first start character is in **cycle 1** at both lanes and cycle 0 is always an
idle word. The guard has no special case, and that fact is a derivation to
check, not a convention to adopt.

---

## 2. The compatibility bar — the forty-eight landed units, and the check that proves it

**The bar.** *Every unit landed before this round must be byte-identical in its
source, in its promotion block and in the code path it drives. The capability is
reached only by naming it.*

Operationally, five clauses:

1. **`create`'s type does not change.** `val create : unit -> t` stays exactly
   as it is. Its **docstring** is re-grounded (§2.1) — a comment, carrying no
   string literal.
2. **`run`'s existing arguments do not move.** `?enable` is added as an optional
   labelled argument before the terminal `unit`, so all **19** existing
   `Bench.run` call sites compile and behave unchanged with no edit.
3. **No existing test file is touched.** The ten `test_m03_*.ml` files do not
   appear in your `git status`. Not one line, not one comment.
4. **The default path is the old path by construction, not by intention.** The
   M03-J4 pre-scan (§3) is entered **only when `Enable.change_cycles` is
   non-empty**. `Enable.high` has no changes, so a `run` with `?enable` omitted
   evaluates `word_at` exactly as many times as it does today, enters no new
   branch and can raise no new exception. State the guard's exact expression in
   the Return log.
5. **`sample`'s new field breaks nothing, and this is measured, not assumed.**
   No file outside `bench.ml` constructs a `sample` or matches one exhaustively
   — every reader projects fields by name (`test_m03_a.ml`'s `tuple_of_sample`
   is the closest thing to an exception and it projects four fields off `s.out`).
   Re-measure it before you write the field; if you find a counter-example, that
   is a BOUNCE-free finding to report, not a thing to work around.

### 2.1 The one comment that must change, and its replacement's content

`bench.mli`'s `create` docstring currently reads:

> Elaborate `Hardcaml_ethernet.Xgmii_rx_64`, release `clear` after one cycle and
> hold `cfg_rx_enable` at 1 for the rest of the run — family J (the disable
> path) is out of this packet's eleven rows (WO-0038 §1) — and attach the three
> standing monitors described above.

After this round that sentence is **false on its face**, and the repair is a
re-grounding rather than a deletion (the pattern `J-dv_lead-0113` §9 used, and
the reason history is kept rather than overwritten). The replacement must say,
in your own line-wrapping: elaborate the module, release `clear` after one
cycle, drive `cfg_rx_enable` = 1 **through that reset cycle** — REQ-009's cycle,
outside every schedule — and attach the three standing monitors; **from cycle 0
the enable is `run`'s `?enable` argument**, whose default `Enable.high` is 1 for
the whole run and is what every unit before WO-0067 was written against. The
module docstring's own family-J sentence (*"no row here drives family J's
disabled-enable frames"*, in the `account_clean_frame` paragraph) is likewise
now false for this file and must be re-grounded the same way, **without**
deleting what it says about family K's `clear`-truncated frames, which is still
true.

### 2.2 The check — the WO-0064 string-literal multiset bar, restated for an
### additive round

WO-0064's bar was *byte-identical multisets*, because that round was a pure
refactor. This round **adds**, so the bar splits in three and each part is a
command whose output goes in the Return log.

**Bar A — the ten existing test files, byte-identical.** WO-0064 §6 bar 1's
command, restricted to the files this round does not touch:

```sh
for f in test/xgmii_rx_64/test_m03_*.ml; do
  b=$(mktemp); a=$(mktemp)
  git show "HEAD:$f" | grep -o '"\([^"\\]\|\\.\)*"' | sort > "$b"
  grep -o '"\([^"\\]\|\\.\)*"' "$f" | sort > "$a"
  if ! diff -q "$b" "$a" >/dev/null; then echo "STRING LITERALS MOVED: $f"; diff "$b" "$a"; fi
done
```

Must print **nothing**. (It will, trivially, because you are not to touch those
files at all — bar A is the proof of clause 3, not a licence to edit under it.)

**Bar B — `bench.ml`'s multiset is a strict superset, enumerated.** Run the same
extraction over `bench.ml` at `HEAD` and at your tree, `diff` them, and put the
diff in the Return log with **one line of justification per added literal**
naming which of the two new mechanisms it belongs to (the M03-J4 guard's
message, or `Enable.report`'s rendering). **No literal may be removed or
changed**; a removal is BOUNCE **B2**. `bench.mli` gains no literal at all
(everything added there is a comment or a signature).

**Bar C — the promotion blocks could not tell.** Extract every
`[%expect {…}]` block from the ten existing test files at `HEAD` and at your
tree and compare byte-for-byte. All must be identical. This is WO-0064's bar 10
— the part of that bar which carried the actual meaning — and it is the one
clause of this section that would catch a capability that changed the DUT's
observed behaviour rather than merely its options.

**Bar D — the default path.** Quote, in the Return log, the exact source line
that guards the pre-scan, and the exact default of `?enable`.

**Bar E — the staged set.** `git status --porcelain` contains exactly the files
of §7.1 and nothing else.

---

## 3. The M03-J4 guard — the constraint is the deliverable as much as the
## capability is

`idle_injection.mli`'s opening rule is this file's rule too, and it is why the
guard is specified here rather than left to each row.

**What it checks.** Before a single cycle is driven, and only when
`Enable.change_cycles` is non-empty, `run` walks cycles `0 .. total - 1`,
evaluates `word_at ~cycle` and `Enable.value_at ~cycle`, and collects every
cycle `c` at which **both** (i) the driven value differs from the value at
`c - 1` (with `true` taken as the value before cycle 0, §1.4), and (ii)
`Dv_xgmii.Xgmii_word.start_lane (word_at ~cycle:c)` is `Some _`. If that
collection is non-empty, `run` **`failwith`s naming every such cycle and its
start lane**, citing SPEC-M03 §6.3 item 7 and C-14.5.

**Why it refuses rather than records — the one place this file's rule differs
from `Idle_injection`'s, and the difference is derived.** `Idle_injection`
*records* an illegal site and **still applies it**, deliberately: *"so that a
bench which ignores `errors` fails loudly on the abort it provoked rather than
passing on a stimulus it did not intend."* That disposition is right there
because the illegal stimulus produces a **determinate wrong answer** — REQ-105's
abort — which a bench cannot miss. Here the illegal stimulus produces **no
determinate answer at all** (§6.3 item 7: *"a bench that changes the input on the
start character's own cycle and asserts either outcome is flaky by
construction"*). A recorded-and-applied same-cycle change would therefore pass
**or** fail depending on the design, and a pass would enter a sign-off packet as
coverage of a stimulus the specification refuses to constrain. The two
constraints have opposite failure modes and so take opposite dispositions:
record-and-apply there, refuse-to-drive here. This paragraph belongs in
`bench.mli`'s `run` docstring in substance; write it in your own words.

**Why it reads the driven word and not the schedule.** Restated because it is
the single most likely thing to be got wrong: at M03-N4 the start character is
placed by `Dv_xgmii.Injection` and arrives through `?word_at`. It is absent from
`Arrival`. A guard built on `Arrival.start_cycles` reports clean on the one
stimulus the guard exists for. **Checking against `Arrival` is BOUNCE B4**, and
it is a BOUNCE even though no row in *this* packet drives an injected start
character — the guard is being built now for the round that will.

**Where the walk sits relative to obligation 5.** After `Arrival.check sched`
and before the first `sample_cycle`, in the same "nothing is driven until the
stimulus has been checked" position and for the same stated reason.

---

## 4. The naming-axis cell — the parked debt this round pays

`bench.mli`'s WO-0064 naming-axis block (the doc comment above
`account_dropped_frame`, whose two bullets split `_frame` from `_piece` on
whether a genuine `Dv_xgmii.Arrival.frame` record exists) is **incomplete**, and
the gap is mine (`J-dv_lead-0113` §8, carried at `RV-0065B-VERDICT` §7.1 and
`WO-0066` §10 with this round as its named carrier). It rides here because this
round opens the file, and it moves no code.

**Where it lands.** As a **third bullet plus its short ground**, inside that
same block, after the existing `_piece` bullet and before the
`account_dropped_frame` docstring. Not in a new block, not at
`account_forwarded_piece`, not in the module header: it lands where the axis is
stated, because the axis is what it corrects, and because the banked rule
(`J-dv_lead-0108`, applied a second time at `delivered_samples`) is that a rule
belongs where the **next reader meets the instrument**.

**What it must say.** The axis as landed splits on whether a record exists.
That is not the whole question, and reading it as though it were convicts a
correct call site. A genuine `Arrival.frame` **whose received extent is shorter
than its declared array** takes the `_piece` entry points even though it *has* a
record — because `account_clean_frame` would size `Latency.frame_in`'s input
trace from the **declared array** while the frame received less, with no
`?expected_octets` override to correct it, and `~received`-honesty is the
precondition that actually carries the weight (the `account_forwarded_piece`
docstring already states it; this bullet is what routes a caller to it).

**The instance, measured at this tree rather than quoted.** In
`test/xgmii_rx_64/test_m03_n.ml`, frame A's schedule array is
`List.init (max 5 (sc.t_idx + 1))`, giving declared arrays of **11, 7 and 5**
octets across the six sub-cases, against received extents of **8, 4 and 0** —
shortfalls of 3, 3 and 5. Frame A therefore has a record and still takes
`account_forwarded_piece` / `account_dropped_piece`, which reads as an axis
violation and is not. **Verify those six numbers yourself** from `sc1 … sc6`'s
`t_idx` and `a_delivered` fields before you write them down; if your reading
differs from mine, report the difference rather than writing mine.

**The rule to state, in one sentence the next reader can apply**: read the axis
as `_frame` where the **declared array is the received extent**, `_piece`
wherever it is not — whether or not a record exists. Cite `J-dv_lead-0113` §8.
The class is *"every frame REQ-110 aborts"*, and it is not only REQ-110's:
REQ-105's and REQ-108's early closures produce it too.

**Comment-only.** If this bullet's landing changes one character of executable
code, that is BOUNCE **B6**.

---

## 5. The rows — M03-J1, M03-J2, M03-J3

Three rows, **three units**, in one new file `test/xgmii_rx_64/test_m03_j.ml`.
Every derivation below is owed a check; §9 bar 2 is where you record the
checking.

### 5.1 The shared stimulus for M03-J1 and M03-J2, and why they share one

requirements.md **REQ-810**'s verification column commissions **one** stimulus
for both rows and it is quoted here in full because the economy is its, not
mine:

> Drive `receive enable` = 0 **with no frame in flight** and inject 100 frames:
> assert no output word, no header `valid` and no strobe anywhere; re-enable and
> check the next frame is received correctly.

So: **101 frames**, one schedule, one runner, two units. Frames 0 … 99 are the
hundred REQ-810 refuses; frame 100 is the one admitted after the change.
Building them as two schedules would let the two rows drift apart on the one
number they must agree about (the change cycle), which is the defect §1.3(d)
rejects a closure for.

**The schedule.** `frames_at ~lane:0 ~fcs_valid:true` over 101 frames, each
`Dv_xgmii.Frame.stress_frame ~sequence:n ()` — 64 octets DA through FCS, with
its own four-octet sequence number at offsets 14 … 17. `Frame.stress_frame` and
not `directed_frame_octets`, for a derived reason: `Frame.sequence_of` reads the
sequence back off a delivered octet string, so M03-J2 can assert that the
delivered frame **is frame 100** — a provenance assertion — rather than merely
that *a* frame arrived.

**The arithmetic, to be checked.** `Arrival.create`'s default `ifg` is 12 and
`frames_at ~lane:0` fixes `first_start` at 8. A 64-octet frame occupies
8 preamble + 64 frame + 12 gap = **84** octet times start-to-start (`arrival.mli`
derives this figure from §0.3 and it is REQ-004's own). Therefore:

- frame *n*'s start octet time is `84n + 8`; 84 mod 8 = 4, so **even *n* starts
  at lane 0 and odd *n* at lane 4** — the alternation is a consequence of the
  gap arithmetic, not a setting;
- **frame 99**: start octet time 8324 → cycle **1040**, lane 4; its terminate
  character at octet time `8324 + 8 + 64 =` 8396 → cycle **1049**, lane 4;
- **frame 100**: start octet time `84 × 100 + 8 =` **8408**; 8408 / 8 = 1051
  exactly → start cycle **1051**, **lane 0**;
- **cycle 1050** covers octet times 8400 … 8407, every one of them inside
  frame 99's 12-octet gap: an **all-idle word**, carrying no start character and
  no terminate character.

**The change cycle is therefore 1050** — M03-J2's *"at least one cycle before a
start character"* at its tightest legal placement, which is the sharpest form of
the row and is what its cell asks for.

`Enable.changes ~initial:false [ (1050, true) ]`.

**Do not hard-code 1050 or 1051.** Compute the change cycle as
`Arrival.start_cycle frame_100 - 1` and **assert** that
`Arrival.start_cycle frame_100 = 1051` and that the change cycle is 1050, so the
derivation is checked at the site that depends on it. Assert also that
`Xgmii_word.start_lane` of the word at cycle 1050 is `None` — the guard would
catch its absence, and a row that relies on a guard for a fact it can state
itself has one instrument where it could have two.

**The two-lane coverage of the refusal path is a by-product, and must be
asserted, not assumed.** Because 84 is not a multiple of 8, the hundred refused
frames alternate lane 0 and lane 4, so this single schedule exercises REQ-810's
refusal at **both** start lanes. That is the coverage claim, and a claim nobody
measured is not a coverage: assert that `Arrival.start_lanes sched` contains
both 0 and 4 and that the count of each among frames 0 … 99 is **50**.

### 5.2 M03-J1 — unit one

**Row cell**: *"`cfg_rx_enable` = 0 held, 100 frames injected (REQ-810's own
figure). No output word, no header effect and **no strobe** anywhere; the
conservation monitor records all 100 as `frame_in_exempt` (C-2), not as
discards."*

**Asserts, in this order.**

1. **Construction**: `Arrival.check sched` clean (`run` does this, but assert
   `Arrival.is_clean` explicitly so the unit states it); 101 frames; the lane
   counts of §5.1; the change cycle and start cycle above.
2. **The silence** — for every sample with `cycle ≤ 1050`: `out.tvalid` is
   `false` **and** `errors_high` is `[]`. This is the row's whole observable and
   the bound 1050 is derived in §5.1, not chosen.
3. **The driven window** — for every sample with `cycle ≤ 1049`,
   `enable = false`; from 1050 onward, `enable = true`. Read off
   `sample.enable`, which is why the field exists (§1.2).
4. **Accounting**: `Conservation_monitor.frame_in_exempt` once per refused
   frame, `~reason:"cfg_rx_enable = 0 (REQ-810)"` — **100 calls**, and
   `Bench.account_clean_frame` for frame 100, which is delivered in this same
   run and must be accounted or the equation is short by one.
5. **The anti-vacuity control, and it is mandatory**: the **same schedule**
   driven on a **fresh bench** with `?enable:Enable.high`, asserting that all
   **101** frames are delivered — `List.length` of the `tlast` samples is 101,
   and the delivered sequence numbers recovered by `Frame.sequence_of` are
   exactly `0 … 100` in order. Without it, a schedule that carried no start
   characters at all — a construction error, not a design fact — would make
   M03-J1 green. The re-enabled frame 100 alone does **not** discharge this: it
   proves frame 100 is well-formed and says nothing about frames 0 … 99. This
   is BOUNCE **B7**.
6. `assert_monitors_clean ~row:"M03-J1"` on both benches.

**Two things this row must not do.**

- It must **not** call `Conservation_monitor.frame_in` for a refused frame.
  SPEC-M03 §6.1 is explicit: *"a bench's frame-conservation monitor (§0.6)
  counts no frame presented across the disabled window"*. `frame_in_exempt`
  keeps the equation's presented term at zero by construction and records the
  frames in a separate ledger, which is exactly what
  `conservation_monitor.mli`'s deviation 3 built it for, naming REQ-810 by
  number. A `frame_in` here is BOUNCE **B9**.
- It must **not** be read, by this unit or by any later packet, as producing
  *independent* evidence that 100 frames were driven. The exempt count is
  **bench-supplied**: it counts the calls this unit made, not anything the DUT
  did. It is the same not-independent shape as the standing `Strobe_monitor`
  at M03-I2 (`WO-0063B-VERDICT` §5), and the honest evidence that 100 frames
  reached the wire is the schedule's own `frames` array and the control run of
  item 5. Say so in a comment at the call site.

**The latency tagger is silent here and that is a landed rule, not a gap.**
`assert_monitors_clean` demands the tagger's `is_constant` verdict only once
`frames_compared` is positive, *"a frameless run … must not be asked to prove a
claim it was never given the means to make"*. The disabled span compares no
frame; frame 100 supplies the one comparison. No new machinery.

### 5.3 M03-J2 — unit two

**Row cell**: *"`cfg_rx_enable` 0 → 1 at least one cycle before a start
character; then frames. The first frame whose start character is accepted at
least one cycle after the change is received correctly and completely."*

Same runner, same schedule, its own bench.

**Asserts.** Frame 100 is received **correctly and completely**:

- exactly **one** `tlast` sample in the whole run;
- **8** delivered words (60 delivered octets = 7 × 8 + 4), at cycles
  `Arrival.start_cycle frame_100 + 3 + m` for `m = 0 … 7`, i.e. **1054 … 1061**
  — SPEC-M03 §6.1's gapless formula, the same `start_cycle + 3 + m` every
  landed unit of this bench asserts, and it is unaffected by the enable because
  frame 100 is admitted under enable = 1;
- final `tkeep` **0x0F**, `tlast` set on that word only, `tuser`[0] = **0**;
- delivered octets equal `Arrival.delivered frame_100`, and
  `Frame.sequence_of` of those octets equals **100** — the provenance assertion
  §5.1 chose `stress_frame` for;
- `error_pulses` over the whole run is **`[]`**;
- `account_clean_frame` for frame 100; `frame_in_exempt` × 100 for the refused
  ones (this unit drives them too and the equation must balance);
- `assert_monitors_clean ~row:"M03-J2"`.

**This row's stated kill is not reachable under its own stimulus — read §6
before you write a line of it.** Do not write an assertion, a comment or a
Return-log sentence claiming this unit kills *"a design that samples the enable
continuously and truncates the frame it just admitted"*.

### 5.4 M03-J3 — unit three, at **both** start lanes

**Row cell**: *"`cfg_rx_enable` 1 → 0 **mid-frame**, at least one cycle away from
any start character; the frame ends with `/T/`. The in-flight frame **completes
under the old value**: its words, its `tlast`, its FCS/runt verdict and its
strobes are exactly those of the same frame with the enable held at 1. The
**next** frame's start character is not accepted."*

This is ADR-0014 clause 3 made executable, and its kill — *"a design that gates
the datapath rather than the start character"* — is the silent discard REQ-810's
own next clause disclaims.

**Schedule**: `frames_at ~lane ~fcs_valid:true [ f0; f1 ]`, two 64-octet
`stress_frame`s with sequences 0 and 1, driven at **`lane = 0` and `lane = 4`**.

**The arithmetic, to be checked.**

| | `lane:0` (`first_start` 8) | `lane:4` (`first_start` 12) |
|---|---|---|
| frame 0 start octet time / cycle / lane | 8 / **1** / 0 | 12 / **1** / 4 |
| frame 0's own octets (octet times) | 16 … 79 | 20 … 83 |
| frame 0 terminate character | ot 80 → cycle **10**, lane 0 | ot 84 → cycle **10**, lane 4 |
| frame 1 start octet time / cycle / lane | 92 / **11** / 4 | 96 / **12** / 0 |
| frame 0's 8 output words | cycles **4 … 11** | cycles **4 … 11** |

The output cycles are the same at both lanes — `start_cycle + 3 + m` with
`start_cycle` = 1 — which is REQ-101's identical-output-at-either-alignment and
M03-L3's ΔC = 3 in both front-offset classes. Check that rather than take it.

**The change cycle is 5, at both lanes.** Derivation: it must lie strictly
inside frame 0 and must not be a start cycle. Cycle 5 covers octet times
40 … 47, which are frame 0's own octets at both lanes (24 … 31 at lane 0,
20 … 27 at lane 4), and 5 ∉ {1, 11} and 5 ∉ {1, 12}. `Enable.changes
~initial:true [ (5, false) ]`. Assert the cycle is not a start cycle from
`Xgmii_word.start_lane`, as in §5.1.

**Why both lanes, and the reason is not symmetry-for-its-own-sake.** The two
members differ in one observable coincidence, and it is the sharpest thing this
row has:

- At **lane 0**, frame 1's refused start character lands in cycle **11** — the
  very cycle carrying frame 0's `tlast` output word. A design that gated the
  **datapath** on the enable rather than the start character kills that `tlast`
  on exactly that cycle, and this member is where that is visible as a
  coincidence rather than as two separate facts.
- At **lane 4**, the refused start lands in cycle **12**, one cycle *after*
  frame 0's `tlast`. The same defect there shows as a missing word without the
  coincidence, and the member proves the row's verdict does not depend on the
  coincidence.
- Secondarily: the refused start character is at **lane 4** in the first member
  and **lane 0** in the second, so a design that samples the enable at only one
  start lane dies at one member and not the other.

**Asserts, per member.**

1. Construction: schedule clean, start cycles and lanes as tabulated, the change
   cycle carries no start character.
2. **The reference run**: the same schedule on a fresh bench with
   `?enable:Enable.high`. In it, **two** `tlast` words; both frames' delivered
   octets equal `Arrival.delivered`; no strobe.
3. **The comparison, which is the row's own instrument**: frame 0's delivered
   words in the disabled run and in the reference run are **equal as ordered
   tuples of (octets, `tkeep`, `tlast`, `tuser`) and equal in their cycles**.
   `test_m03_a.ml`'s `tuple_of_sample` / `tuple_equal` are the landed shape for
   this comparison; do not invent a second one — but note that this comparison
   is over **cycles as well as tuples**, which that pair does not carry, so the
   cycle equality is asserted alongside it and not folded into it.
   `Bench.split_at_first_tlast` is **not** what you want here and its
   precondition is why (`bench.mli`'s own FINDING B-1 block): use
   `delivered_samples` on each run and compare the lists.
4. **The refusal**: exactly **one** `tlast` sample in the disabled run (the
   reference run has two), and no delivered sample at any cycle at or after
   frame 1's own `start_cycle + 3`.
5. **No strobe anywhere** in the disabled run — frame 0 is clean and closes on
   its own `/T/`, and REQ-810 gives the refused frame 1 no strobe at all. This
   is the assertion that separates ADR-0014's reading from the datapath-gating
   one: under datapath gating frame 0 vanishes **with no `tlast` and no strobe**,
   which fails clause 4 and this clause together.
6. **The driven window** from `sample.enable`: `true` on cycles 0 … 4, `false`
   from 5 to the end of the run.
7. **Accounting**: `account_clean_frame` for frame 0;
   `frame_in_exempt ~reason:"cfg_rx_enable = 0 (REQ-810)"` for frame 1;
   `account_clean_frame` × 2 on the reference bench.
8. `assert_monitors_clean` on both benches, `~row:"M03-J3 (lane 0)"` /
   `"(lane 4)"`.

### 5.5 What the three units are called, and the inventory

Three `let%expect_test`s, one per row, titled with the row id first as every
unit in this bench is (`tools/dv_checks.sh`'s census matches row ids in unit
titles, with a trailing-digit boundary). All three `[%expect {||}]` blocks stay
**empty**: these rows assert, they do not print. The bench inventory moves
**48 → 51** and the census gains **M03-J1, M03-J2, M03-J3**; the inventory is a
report and not a check (`tools/dv_checks.sh` says so in its own comment), so
nothing needs updating for the count — but quote the new figure in the Return
log so the next packet is not quoting a number nobody measured.

---

## 6. The finding this packet makes against my own attack plan — M03-J2's kill

**M03-J2's Kills cell is unreachable under M03-J2's own stimulus, and the defect
is mine.** The cell reads *"A design that samples the enable continuously and
truncates the frame it just admitted."* Work the stimulus: the enable goes
0 → 1 at least one cycle before the start character, and stays 1 for the whole
of the admitted frame. A design that samples the enable **continuously** sees 1
on every cycle of that frame and truncates nothing. There is no design in the
cell's class that this stimulus separates from a conformant one.

The kill it describes belongs to **M03-J3**, whose stimulus takes the enable
1 → 0 *inside* the admitted frame — where a continuously-sampling design does
exactly what the cell says.

This is the **M03-D3 / M03-F2 / M03-I2 unachievable-kill shape**, found the same
way each of those was: by working the row's own arithmetic while authoring the
packet, before a bench existed. Its disposition here follows the same precedent
— the row is **still commissioned**, because its *observable* is sound and is
REQ-803's own (a frame admitted after the change is received completely) and
because REQ-810's verification column commissions it in terms. What changes is
the claim the round may make about it.

**The honest kill for M03-J2, and this is the one you may name**: a design that
**refuses the first frame after a re-enable** — one that latches the enable to a
frame boundary that never arrives while the line is idle, or that needs more
than one cycle of settling before a start character is admitted. §4.3's sentence
is *"a frame whose start character is accepted at least one cycle after the
input changes is governed by the new value"*, and the tightest legal placement
(§5.1's one cycle) is what makes that class reachable at all — which is a second,
independent reason the change sits at 1050 rather than comfortably earlier.

**The plan edit is owed and it is mine, not yours** (§11). Your obligations are
narrow and absolute: do not assert the stale kill, do not repeat it in a comment
or in the Return log, and if any sentence you write would be falsified by this
section, do not write it.

---

## 7. Scope

### 7.1 The files this round stages — exactly four

1. `test/xgmii_rx_64/bench.mli` — the `Enable` module signature, `run`'s
   `?enable`, `sample`'s `enable` field, the `create` and module-header
   re-groundings (§2.1), the `run` docstring's M03-J4 paragraph (§3), and the
   naming-axis bullet (§4).
2. `test/xgmii_rx_64/bench.ml` — `Enable`'s implementation, the pre-scan guard,
   the per-cycle enable drive inside `sample_cycle`, the `sample` field.
3. `test/xgmii_rx_64/test_m03_j.ml` — the three units.
4. `test/xgmii_rx_64/dune` — **only if** the new file needs a declaration there;
   read it first, and if it does not, this file does not appear.

Plus this packet's Return log and your worker journal entry. **Anything else is
BOUNCE B1.**

### 7.2 What does not move, and that is not a claim that it is correct

- **The ten `test_m03_*.ml` files.** Untouched, byte-identical, §2 bar A.
- **`test/xgmii/**`.** No link-partner model changes: §1.3(b) is the ground.
- **`test/monitors/**`.** `Conservation_monitor.frame_in_exempt` already exists
  and already names REQ-810 in its own docstring. Nothing here needs a new
  exemption, which is ADR-0014's Consequences bullet read at its word.
- **`test/attack_plans/AP-xgmii_rx_64.md`.** Not in this round's scope at all
  (it is not in yours; and it is not in mine this round — §11).
- **`create`'s reset-cycle drive** (§1.4).

---

## 8. What this round does **not** commission, each with its ground and its date

**M03-N4 — deferred, and it is dated, not parked.** The capability makes N4
writable; the reason it is not written here is a coverage reason and not a
capability one.

- N4's observable is REQ-110's **abort geometry** — the in-flight frame
  truncated at the octet before the `/S/`, `tuser`[0] on its `tlast`, the
  zero-delivered branch with no output word at all — conjoined with the enable.
  That geometry's report cycles come from SPEC-M03 §6.1's six-row table, which
  **M03-N2's six sub-cases now drive and whose instrument was measured 4/4 at
  `WO-0066`**. N4 belongs beside M03-N1 in `test_m03_n.ml`, reusing that landed
  runner's derivation of the table, and writing it here would build a second
  derivation of the same table in a different file — which is how two readings
  of one table come to exist.
- The honest ordering is therefore: the family-J capability first (this round),
  then an **M03-N1 / M03-N4 round** in `test_m03_n.ml`. N4's own entry in that
  round is *cheaper* than it was before `WO-0066`, which is the argument for the
  order rather than against it.
- **Its date**: the round immediately following this one's `RV-`. This is a
  deferral of a **row**, not of the family-J capability round, and it does not
  reset my two-deferral clock on family J — which this packet discharges.

**M03-J4 — `NO-STIMULUS`, and it stays that way.** It is not a row this or any
round writes: it is a prohibition, and this round **executes** it as the §3
guard. That is M03-J4's discharge in the only form it has.

**Fold-in 3 — not this round, and its pre-committed fallback fires.**
`WO-0066` §10 dated fold-in 3 to *"the first round that opens `test_m03_n.ml` —
the M03-N1/M03-N4 bench round — with a dated fallback: if none is scheduled by
the time family J returns, it is commissioned as a rider on that round's `RV-`."*
This round does not open `test_m03_n.ml` (§8's N4 disposition is why), and no
M03-N1/N4 round is scheduled ahead of it. **The fallback therefore fires
exactly as pre-committed**: fold-in 3 is commissioned as a rider on this round's
`RV-0067-VERDICT`. It is recorded here so the firing is visible in the packet
that caused it and not only in a journal.

**The strobe-multiplicity question** (`WO-0066`'s T8, whether M03's strobe
contract should carry a multiplicity signal) is an architect question, batched
separately, and is **not** this packet's. No row above depends on its answer:
M03-J1's and M03-J3's refused frames produce no strobe at all, so there is no
coincidence for multiplicity to hide.

---

## 9. The review bar — pre-committed, in commands and in readings

1. **Bars A–E of §2**, each with its command and its output quoted in the Return
   log. Bar A and Bar C must be empty; Bar B's diff must be enumerated with one
   justification per added literal.
2. **The derivations, checked and shown.** For each of these, the Return log
   carries your own arithmetic, not a restatement of mine: frame 100's start
   octet time and cycle; cycle 1050's contents; the 50/50 lane split over frames
   0 … 99; frame 0's terminate cycle and frame 1's start cycle at **both** lanes
   in §5.4's table; the eight output cycles 1054 … 1061 and 4 … 11. **A
   disagreement with my number is a finding I want, not a bounce** — report it
   and stop.
3. **The M03-J4 guard reads driven words.** I will read the guard's source. It
   must call `word_at` (the same function `run` drives from), never
   `Arrival.start_cycles`.
4. **The default path.** I will read `run`'s body for the pre-scan's condition
   and confirm the omitted-`?enable` case reaches no new code.
5. **The naming-axis bullet** — read clause by clause against §4, in place in the
   WO-0064 block, comment-only, with the six numbers verified independently.
6. **Parse**: `ocamlc -stop-after parsing` exit 0 on the files you staged.
   Neither you nor I claim a `dune runtest` result (ADR-0005); CI at the landing
   commit is the adjudicator and its run id goes in the Return log if it exists
   by then.
7. **`tools/dv_checks.sh`** run and its inventory and census output quoted, with
   48 → 51 and the three new census rows named.
8. **Independence**: your journal `Inputs` names this packet, your charter,
   PROTOCOL, and `test/**` paths. No `libs/**`, no `rtl_snapshots/**`. Spec
   paths are permitted and expected — the excerpts are quoted in this packet,
   but reading the four named sections yourself is better than trusting my
   quotation, and §9 bar 2 half expects you to.
9. **No claim this packet forbids.** §6's stale kill appears nowhere in your
   output. §5.2's not-independent caution on the exempt ledger appears at the
   call site.
10. **The staged set** is exactly §7.1.

---

## 10. BOUNCE conditions — pre-committed

| # | Condition |
|---|---|
| **B1** | Any file outside §7.1 appears in `git status --porcelain`, or any of the ten existing `test_m03_*.ml` files is edited by one character. |
| **B2** | `create`'s type changes; or any existing `Bench.run` / `Bench.create` call site is edited; or a string literal is **removed from or changed in** `bench.ml` (additions are §2 bar B's business). |
| **B3** | Any `[%expect …]` block in the ten existing files differs by one byte. |
| **B4** | The M03-J4 guard is absent, or derives start cycles from `Arrival` rather than from the driven word. |
| **B5** | Any row places an enable change on a cycle carrying a start character, or asserts any outcome of such a placement. |
| **B6** | The naming-axis bullet is missing, lands outside `bench.mli`'s WO-0064 axis block, or changes one character of executable code. |
| **B7** | M03-J1's unit lacks the `Enable.high` control run of §5.2 item 5, or that control asserts fewer than 101 delivered frames. |
| **B8** | Any assertion, comment or Return-log sentence claims M03-J2 kills the class §6 shows unreachable. |
| **B9** | `Conservation_monitor.frame_in` is called for a frame refused while the enable is 0, in any unit. |
| **B10** | The pre-scan runs when `?enable` is omitted, or `run`'s behaviour with `?enable` omitted differs from `HEAD`'s in any respect you cannot show is a no-op. |
| **B11** | A `dune runtest` or `dune build` result is claimed in the Return log (ADR-0005). |
| **B12** | The three units print anything — a non-empty `[%expect]` block. |

---

## 11. What I owe after this round, recorded so it cannot evaporate

Plan edits to `test/attack_plans/AP-xgmii_rx_64.md`, mine, in the next round
that opens that file — **not** the executor's, and **not** this round's (my
write scope this round is `agents/handoffs/` and my journal):

1. **M03-J2's Kills cell** — §6's finding: the stated kill is unreachable under
   the row's own stimulus and belongs to M03-J3; the honest kill named, with the
   M03-D3 / M03-F2 / M03-I2 precedent cited. History kept, ground replaced.
2. **M03-J1's Observable cell** — the `frame_in_exempt` demand is **correct and
   is not stale**, and the cell should say why in one clause so the next reader
   does not re-litigate what §5.2 had to derive: the equation's *presented* term
   is zero (SPEC-M03 §6.1), the exempt ledger is outside the equation
   (`conservation_monitor.mli` deviation 3, naming REQ-810), and ADR-0014's
   *"needs no new exemption"* is about the **in-flight** frame at M03-N4, not
   about the refused frames here. Plus the not-independent caution.
3. **§7's machinery table** — a row recording that the `cfg_rx_enable` schedule
   landed and that its M03-J4 constraint is the deliverable as much as the
   schedule is, on the X-4 precedent. §7's *"Not gaps"* paragraph is unchanged:
   it says the exemption machinery *"is used by M03-J1 and M03-K2"*, and after
   this round that is true of J1 for the first time.
4. Carried from `J-dv_lead-0118` item 5, both clerical: §4.H bound 1's stale
   tense, and §9's change-log row with no Author cell.

---

## 12. Your return

A **Return log** appended to this file, under a heading naming you and your
spawn short-id, carrying: §9's ten bars each with its command and observed
output; §9 bar 2's arithmetic in your own working; the added-literal enumeration;
the guard's source line; any disagreement with any number in this packet, stated
as a disagreement and not silently resolved; and the questions you want ruled
rather than guessed. Then your journal entry per PROTOCOL §4, `task:WO-0067`,
with the spawn short-id in Trigger.

**A question asked is never a defect in this house. A number taken on trust is.**

---

## Return / verdict log

### tb_writer's Return — spawn `WO-0067/2026-08-05T14:00Z`

No explicit spawn short-id token was included in this session's dispatch
text (PROTOCOL §4.1's format, `<WO-id>/<spawn-UTC-timestamp>`); I minted the
one above from the WO id and today's date rather than cite a token I was
never actually given, and flag that here rather than silently presenting it
as received.

**Toolchain note, stated up front because it bears on every bar below.** My
tools this spawn are Read/Grep/Glob/Edit/Write and `ocamlc -stop-after
parsing` via Bash — nothing else. I could not run `git status`,
`git show`, `diff`, or `tools/dv_checks.sh` (all of §9 bars A, C, E and
review bar 7's own commands are shell commands other than the one permitted
invocation). Every claim below that would ordinarily be a shell command's
literal output is instead a structural attestation from my own Read/Edit/
Write history in this session, stated as such — dv_lead's own re-run of
the literal commands is what actually closes each bar; I did not fabricate
command output.

#### (a) The `Enable` module + pre-scan, as encoded

`test/xgmii_rx_64/bench.mli` — `Enable` matches §1.2's signature exactly:
`high`, `low`, `changes ~initial (int*bool) list -> t` (raises on a
cycle ≤ 0, non-ascending, or a change equal to the value already in
force), `value_at`, `change_cycles`, `report`. `run` gains `?enable`
immediately before the terminal `unit`; `sample` gains `enable : bool`
immediately after `in_word`.

`test/xgmii_rx_64/bench.ml` — `Enable` is `{ initial : bool; changes :
(int * bool) list }`; `value_at` folds left over `changes`, taking the
last entry at or before the queried cycle (correct because `changes` is
already ascending and non-redundant by construction); `change_cycles t =
t.changes`. `sample_cycle` gains `~enable`, drives `i.cfg_rx_enable := if
enable then Bits.vdd else Bits.gnd` at the SAME point `Xgmii_probe.to_refs`
drives the word (the choke point, §1.1(R-e)), and records `enable` in the
returned record. `run`'s pre-scan — the exact source, `bench.ml`:

```
  (match Enable.change_cycles enable with
   | [] -> ()
   | _ :: _ ->
     let violations =
       List.filter_map (List.range 0 total) ~f:(fun cycle ->
         let prev_enable = if cycle = 0 then true else Enable.value_at enable ~cycle:(cycle - 1) in
         let this_enable = Enable.value_at enable ~cycle in
         if Bool.equal prev_enable this_enable
         then None
         else (
           match Xgmii_word.start_lane (word_at ~cycle) with
           | None -> None
           | Some lane -> Some (cycle, lane)))
     in
     (match violations with
      | [] -> ()
      | _ :: _ -> failwith (...)));
```

reads `word_at ~cycle` — the SAME function `drive` calls two lines later —
never `Arrival.start_cycles`, so it sees an injected start character
through `?word_at` exactly as a future M03-N4 row would drive one. It
`failwith`s (refuses) rather than recording-and-applying, matching §3's own
disposition argument. `create`'s own reset-cycle drive
(`i.cfg_rx_enable := Bits.vdd`) is untouched, one line, comment re-grounded
only.

#### (b) Per-row derivation — agree/disagree vs the packet's numbers

Every number in §5.1 and §5.4 was re-derived independently before being
written into `test_m03_j.ml`'s own assertions (which additionally check
themselves against the packet's own frozen expectations, `<> 1051` etc.,
`fail`-ing loudly on disagreement rather than silently taking either
figure). **All AGREE**:

- Frame 100's start octet time `84 * 100 + 8 = 8408`; `8408 / 8 = 1051`
  exactly, lane `8408 mod 8 = 0`. **Agree** (1051, lane 0).
- Frame 99: start octet time `8324`, cycle `1040`, lane 4; terminate octet
  time `8396`, cycle `1049`, lane 4. Cycle 1050 covers octet times
  8400–8407, all inside frame 99's own 12-octet gap `[8396, 8407]` —
  all-idle, no start character. **Agree** with the change cycle 1050.
- 50/50 lane split, frames 0..99: `84n + 8 ≡ 4n (mod 8)` — 0 for even `n`,
  4 for odd `n`; 50 even, 50 odd in `0..99`. **Agree**, and asserted at
  site against `frames.(0..99)`'s own `start_lane` field, not merely
  against `Arrival.start_lanes`'s flat membership.
- Frame 100's 8 output words at `1051 + 3 + m` for `m = 0..7` = cycles
  1054..1061; final word `m=7` tkeep 0x0F (60 delivered octets = 7×8+4).
  **Agree**.
- J3 lane 0: frame 0 start cycle 1 (`8/8`), terminate octet time
  `8+8+64=80` → cycle 10 lane 0; frame 1 start octet time `8+84=92` →
  cycle 11 (floor), lane 4. Frame 0's 8 words at cycles 4..11 (`1+3+m`).
  **Agree.**
- J3 lane 4: frame 0 start cycle `floor(12/8)=1`; terminate octet time
  `12+8+64=84` → cycle 10 (floor), lane 4; frame 1 start octet time
  `12+84=96` → cycle 12, lane 0. Frame 0's 8 words again at cycles 4..11
  (same `start_cycle=1`). **Agree**, including the "same output cycles at
  both lanes" coincidence the packet calls out.
- Change cycle 5, both lanes: covers octet times 40–47, entirely inside
  frame 0's own frame octets at both lanes (16..79 at lane 0, 20..83 at
  lane 4), and 5 ∉ {1, 11} / {1, 12}. **Agree.**

No arithmetic disagreement found anywhere in §5.

**One disagreement, not in §9 bar 2's own list but found while checking
compatibility bar clause 2**: §2 clause 2 states "all **19** existing
`Bench.run` call sites compile." I count **44** existing call sites (before
`test_m03_j.ml`'s own 3): `test_m03_a.ml` 2, `test_m03_b.ml` 6,
`test_m03_c.ml` 3, `test_m03_d.ml` 3, `test_m03_e.ml` 4, `test_m03_f.ml` 4,
`test_m03_g.ml` 8, `test_m03_h.ml` 4, `test_m03_i.ml` 7, `test_m03_n.ml` 1,
`test_m03_structural.ml` 1, `bench.ml`'s own `run_directed_lengths` 1 — sum
44 (Grep tool, pattern `run (bench|baseline_bench|overlay_bench)
(sched|inj_sched)`, glob `*.ml`, path `test/xgmii_rx_64`, count mode,
reproducible from a checkout). The compatibility ARGUMENT is unaffected
either way (every call site ends in a bare `()` with no `?enable` named, so
none is edited regardless of whether there are 19 or 44 of them) — this is
a count disagreement, not a defect in the compatibility bar itself, and I
report it per §9 bar 2's own instruction rather than silently quoting 19.

#### (c) The compatibility bar's five checks — results

1. **`create`'s type unchanged.** `val create : unit -> t` — byte-identical
   in signature; docstring re-grounded per §2.1 (comment only).
2. **`run`'s existing arguments not moved.** `?enable` inserted immediately
   before the terminal `unit`; the four prior parameters (`t`,
   `Dv_xgmii.Arrival.t`, `~drain`, `?word_at`) are in the same order. All
   44 measured call sites (see (b) above) pass no `?enable` and end in a
   bare `()`, so all compile unchanged.
3. **No existing test file touched.** `bench.mli`, `bench.ml` and the new
   `test_m03_j.ml` are the only files I opened for writing. I could not run
   Bar A's literal command (Bash restricted to `ocamlc`); attested instead
   from my own Edit/Write history — I never opened any `test_m03_*.ml`
   file other than the new `test_m03_j.ml`. dv_lead's own re-run of Bar A's
   command is the actual closure of this clause.
4. **The default path is the old path by construction.** Exact guarding
   expression, quoted in (a) above: `match Enable.change_cycles enable
   with | [] -> () | _ :: _ -> ...`. `Enable.high = { initial = true;
   changes = [] }`, so `change_cycles Enable.high = []` and an
   `?enable`-omitted call (which defaults to `Enable.high`, `let enable =
   match enable with Some e -> e | None -> Enable.high in`) takes the `[]`
   branch, entering none of the guard's own code and calling `word_at`
   exactly once per driven cycle, as before. `Enable.value_at Enable.high
   ~cycle` is `true` for every cycle (empty `changes`, fold returns
   `t.initial`), so `sample_cycle` drives `i.cfg_rx_enable := Bits.vdd`
   every cycle under the default — the SAME value `create` set once and
   left; re-setting a ref to its own held value has no additional
   Cyclesim effect, so this is a no-op relative to HEAD's behaviour.
5. **`sample`'s new field breaks nothing — measured.** Grep tool,
   patterns for record-pattern matches / exhaustive construction of
   `sample` across `test/xgmii_rx_64/*.ml` and `bench.ml` itself: every
   site outside `bench.ml` projects fields by name (`s.out`, `s.cycle`,
   `s.errors_high`, `(s : sample)` as a type annotation only) or calls a
   `Bench`-provided accessor (`delivered_samples`, `tlast_sample`,
   `error_pulses`); `test_m03_a.ml`'s `tuple_of_sample` is the closest
   thing to an exception, and it too only projects `s.out...` fields. No
   counter-example found — none to report.

#### (d) Files created/edited

- `test/xgmii_rx_64/bench.mli` — edited (Enable module signature, `run`'s
  `?enable` + M03-J4 guard doc, `sample`'s `enable` field, `create`'s and
  the module header's re-grounded comments, the naming-axis third bullet).
- `test/xgmii_rx_64/bench.ml` — edited (Enable implementation, the guard,
  `sample_cycle`'s `~enable` drive, `sample`'s `enable` field, two
  comment re-groundings).
- `test/xgmii_rx_64/test_m03_j.ml` — created (M03-J1, M03-J2, M03-J3,
  three `let%expect_test`s, all `[%expect {||}]` empty).
- `test/xgmii_rx_64/dune` — **not touched**: read first (already on
  record in this packet's own §7.1 item 4 condition), confirmed no
  `(modules ...)` restriction exists, so the new file needs no
  declaration.
- This Return log, appended to this file.
- My journal entry, `J-tb_writer-0026`.

Nothing else. `git status --porcelain` itself could not be run this spawn
(tool boundary); the set above is exact per my own Edit/Write history.

#### (e) Syntax checks

`ocamlc -stop-after parsing` on each edited/created file this spawn, in
this repo checkout:
- `test/xgmii_rx_64/bench.mli` — exit 0.
- `test/xgmii_rx_64/bench.ml` — exit 0.
- `test/xgmii_rx_64/test_m03_j.ml` — exit 0 (re-run after a self-caught
  fix, see (i) below).

No `dune build` / `dune runtest` claimed (BOUNCE B11, ADR-0005) — CI at
the landing commit is the adjudicator.

#### (f) BOUNCE conditions — none hit that I can find

Checked against all twelve: B1 (only §7.1's files touched, dune excluded
correctly), B2 (`create`'s type unchanged, no call site edited, no
literal removed — see (g) below), B3 (n/a, no existing file touched), B4
(guard reads `word_at`, never `Arrival.start_cycles` — quoted in (a)), B5
(every enable change in J1/J2/J3 is checked against its own driven word's
`start_lane` and `fail`s the row as a "test bug" if it ever lands on one —
none does under the derived numbers), B6 (naming-axis bullet lands inside
the existing WO-0064 block, comment-only), B7 (M03-J1's `Enable.high`
control run asserts exactly 101 delivered/tlast frames and their sequence
provenance), B8 (M03-J2's comment explicitly disclaims the stale kill and
names the honest one instead — no assertion or Return-log sentence claims
the unreachable class), B9 (`frame_in_exempt` only, never `frame_in`, for
any refused frame in any of the three units), B10 (guarded and argued in
(c) item 4), B11 (none claimed), B12 (all three `[%expect]` blocks empty).

#### (g) Bar B — bench.ml's literal multiset, enumerated

Could not run Bar B's literal command (tool boundary). Enumerated by
reading my own diff instead — every literal I added to `bench.ml`, none
removed or changed:

| Literal | Mechanism |
|---|---|
| `"Bench.Enable.changes: "` | `Enable.changes`'s own construction-guard message prefix |
| `" is not positive"` | `Enable.changes`'s positivity check |
| `" does not strictly ascend past "` | `Enable.changes`'s ascending-order check |
| `" changes to "` | `Enable.changes`'s already-in-force check |
| `", which is already the value in force"` | same message, continued |
| `"initial "` | `Enable.report`'s rendering |
| `" -> "` | `Enable.report`'s rendering (change separator) |
| `"Bench.run: cfg_rx_enable changes on the same cycle as a start character (SPEC-M03 §6.3 item 7, carry-forward C-14.5) — the outcome is deliberately unconstrained and SHALL NOT be driven, at:"` | the M03-J4 guard's `failwith` |
| `"  cycle "` | the M03-J4 guard's per-violation line |
| `", start lane "` | the M03-J4 guard's per-violation line, continued |

Ten literals, all additions, each belonging to exactly one of the two
named mechanisms. `bench.mli` gains no literal (comments/signatures only).
dv_lead's own re-run of Bar B's command is what actually closes this bar;
this table is my own accounting of the diff I made, not a substitute for
that run.

#### (h) Bar D — the default path, quoted

Guard entry: `match Enable.change_cycles enable with | [] -> () | _ :: _ ->
...` (quoted in full in (a)). Default: `let enable = match enable with
Some e -> e | None -> Enable.high in`.

#### (i) What dv_lead should review first

1. **The `%`/`Int.rem` self-catch** (below, (j)) — I introduced an
   undefined `%` operator in `test_m03_j.ml` that `ocamlc -stop-after
   parsing` passed silently (it only parses; it does not resolve names).
   Found by grepping the rest of the suite for its own modulo idiom
   (`Int.rem`, used everywhere, `%` used nowhere) before this Return log
   was written, and fixed. I re-ran the parse check after the fix (exit
   0) but **cannot rule out a second instance of the same class of error
   anywhere else in `test_m03_j.ml`** — a parse-only check is structurally
   blind to it, and dv_lead's own review (or CI's actual typecheck) is
   the only instrument that closes this class fully. Worth a deliberate
   look rather than trusting the green parse.
2. The J3 word-comparison instrument (`disabled_words` vs `ref_frame0_words`,
   via plain `List.take`/`List.drop` slicing rather than
   `split_at_first_tlast`) — a design choice explained inline at the call
   site; worth confirming it reads as the intended "straight slice
   comparison" rather than as an avoidance of a tool I should have used.
3. The M03-J2 honest-kill comment (§6) — confirm it neither claims the
   stale kill nor over-claims the honest one.
4. The 44-vs-19 call-site count disagreement in (b) above.

#### (j) World-inconsistency found and stopped on rather than repaired

One, self-inflicted rather than found in the world: my own first draft of
`test_m03_j.ml` used `%` as a modulo operator (`terminate_ot0 % 8`), which
is not a bound operator in this codebase's toolchain (every other file
uses `Int.rem`). `ocamlc -stop-after parsing` cannot catch an unbound
operator — it stops before name resolution — so this passed the only
check available to me silently. I caught it myself, before writing this
Return log, by grepping the rest of the suite for the modulo idiom
actually in use and finding zero other occurrences of `%`. Fixed to
`Int.rem terminate_ot0 8`, re-parsed (exit 0). Recorded here in full
because it is exactly the class of error this spawn's toolchain
(ADR-0005) is structurally unable to catch on its own, and dv_lead should
not read a clean `ocamlc -stop-after parsing` result as ruling it out
elsewhere in the file.

No other world-inconsistency (missing file, unresolvable citation) was
found — every spec section, module `.mli` and packet citation this WO
named resolved to real, readable text.

---

## RV-0067-VERDICT (dv_lead, 2026-08-05) — **ACCEPT**

**State: ACCEPTED.** The capability is the shape §1.2 specifies, member for
member; the M03-J4 guard reads the driven word and refuses rather than records;
all three runners' arithmetic agrees with a derivation I performed before
reading the Return log's §(b); the naming-axis bullet is comment-only on a
mechanical proof, not on a reading; **CI is green at `e4df986` with the
promotion gate clean**; and the five compatibility bars — three of which the
worker could not run and correctly refused to fake — pass on my own re-run.

**One number in this packet was wrong and the Return log was right to say so.**
It was not 44 either. §5 below rules it: the true figure is **45**, mine was
stale by eight rounds, and the round's compatibility argument is untouched.

**Nothing in this verdict is a reviewed repair.** §9 says why that is a
conclusion and not an omission.

---

### 1. CI — the landing evidence, read at the source

| Workflow | Run | Job | Conclusion |
|---|---|---|---|
| `build` | **`30980439774`** | `build` **`92223513938`** | **success** |
| `build` | `30980439774` | `cosim` `92223513859` | **success** |
| `journal-check` | **`30980439829`** | — | **success** |

**Green — not a promotion loop, and not a mismatch.** The distinction the
review asked for is made from the step list, not from the run's colour:

- **Step 5, `Build` — success.** `opam exec -- dune build @default`. Per this
  directory's own `dune` header, CI's `dune build @default` is the *only*
  compiler that reaches `test/xgmii_rx_64/` (it is excluded from
  `tools/precompile_check.sh`'s STUBBABLE set by construction). Its success is
  therefore the first full name-resolution pass over `test_m03_j.ml` that has
  ever run. This is what discharges §4.1's `%`-class residue, and no earlier
  instrument could have.
- **Step 6, `Run tests` — success.** `dune runtest`; on any failure it promotes,
  prints the `PROMOTION BLOCK` and exits 1. It printed no block. Every assertion
  in `run_j1`, `run_j2` and `run_j3 ~lane:0 / ~lane:4` raises `failwith`, which
  lands as an `expect.uncaught_exn` correction and fails this step — so
  **silence here is a positive result**, not an absence of one. All three units
  executed and every derived figure inside them held against the design.
- **Step 8, `Verify nothing was left unpromoted or non-deterministic` —
  success.** `git add -A; git diff --cached --exit-code`. The three
  `[%expect {||}]` blocks are still empty at the landing tree: **B12 clear, and
  no promotion is owed.** This step is also the strongest available evidence for
  **B10**'s second clause — see §3.3.

The three new units' expects being empty makes this *harder* to read, not
easier, and that is why the two steps are separated above: an empty expect block
is indistinguishable from an unrun unit in the run's colour alone. Step 6's own
failure semantics are what tell them apart.

---

### 2. The bar table

**BOUNCE conditions (§10) — twelve of twelve clear.**

| # | Condition | Verdict | How I checked it |
|---|---|---|---|
| **B1** | File outside §7.1 staged, or an existing `test_m03_*.ml` edited | **clear** | `git show --name-only e4df986`: `bench.ml`, `bench.mli`, `test_m03_j.ml`, + packet + worker journal. `dune` correctly absent (no `(modules …)` restriction — I re-read it) |
| **B2** | `create`'s type changes / a call site is edited / a literal is removed or changed in `bench.ml` | **clear** | Comment-stripped `bench.mli` diff (§3.4) shows `create` untouched; Bar A shows no existing file changed at all; Bar B's diff is **additions only, zero `<` lines** |
| **B3** | An `[%expect …]` block in an existing file differs by a byte | **clear** | Bar C, re-run over all eleven pre-existing files: empty |
| **B4** | Guard absent, or derives start cycles from `Arrival` | **clear** | Guard calls `Xgmii_word.start_lane (word_at ~cycle)` — the same `word_at` `drive` calls two lines later. `Arrival.start_cycles` appears nowhere in `run` |
| **B5** | A row places an enable change on a start-character cycle | **clear** | Asserted at site in all three runners; **and** the guard itself ran under J1/J2/J3 in CI and did not raise, which is the independent confirmation |
| **B6** | Naming-axis bullet missing, misplaced, or touches executable code | **clear** | Mechanically: comment-stripped `bench.mli` differs in exactly three places, all of them the commissioned signature additions (§3.4) |
| **B7** | M03-J1 lacks the `Enable.high` control, or it asserts < 101 frames | **clear** | `test_m03_j.ml:216–253`: fresh bench, 101 `tlast` words, 101 segmented chunks, and `Frame.sequence_of` over each chunk equal to `0 … 100` **in order** |
| **B8** | Any output claims M03-J2's unreachable kill | **clear** | Checked in the unit (`:280–296` disclaims it in terms), in the Return log, and in `J-tb_writer-0026`. Adjudicated at §4.3 |
| **B9** | `frame_in` called for a frame refused while the enable is 0 | **clear** | `frame_in_exempt` at all three refusal sites; the only `frame_in` calls are inside `account_clean_frame`, for frames the design **admitted** (frame 100, frame 0) |
| **B10** | Pre-scan runs with `?enable` omitted, or default behaviour differs | **clear** | By construction and by measurement — §3.3 |
| **B11** | A `dune` result is claimed in the Return log | **clear** | Return log §(e) and journal Evidence both state `dune build`/`dune runtest` **not run** |
| **B12** | The three units print anything | **clear** | Three `[%expect {||}]`, still empty after CI step 8 |

**Compatibility bars A–E (§2.2) — re-run by me, not accepted as attested.** The
worker's toolchain could not run A, C or E and it said so instead of fabricating
output. That was the correct call, and it is what left these open; they are
closed here.

| Bar | Result | Evidence |
|---|---|---|
| **A** — the existing test files' literal multisets, byte-identical | **PASS, empty** | §2.2's own command, `e4df986~1` → `e4df986`, over every pre-existing `test_m03_*.ml` (eleven of them — §6.4). No output |
| **B** — `bench.ml`'s multiset a strict superset | **PASS** | **15 added extraction-lines, 0 removed, 0 changed** — every hunk an `a`. Enumerated at §6.3 |
| **C** — the promotion blocks could not tell | **PASS, empty** | Every `[%expect …]` block in every pre-existing file byte-identical across the round |
| **D** — the default path | **PASS** | Guard entry `match Enable.change_cycles enable with \| [] -> () \| _ :: _ -> …`; default `let enable = match enable with Some e -> e \| None -> Enable.high in` |
| **E** — the staged set | **PASS** | Exactly §7.1 items 1–3, + packet + worker journal. Item 4 (`dune`) correctly absent |

**Review bar §9 — ten of ten.** 1 (bars, above); 2 (derivations, §3.5 — all
agree); 3 (guard reads driven words, §3.2); 4 (default path, §3.3); 5 (bullet
clause by clause with the six numbers re-verified, §3.4); 6 (parse ×3 exit 0,
superseded by CI's actual compile); 7 (`tools/dv_checks.sh` — the worker could
not run it; I did, §7); 8 (independence — `J-tb_writer-0026`'s `Inputs` names
the packet, charter, PROTOCOL, four spec files and `test/**` paths, and states
`libs/**`, `top/**`, `rtl_snapshots/**` were never opened); 9 (no forbidden
claim; the not-independent caution appears at **both** exempt-ledger call sites,
`:203–210` and `:354–356`); 10 (staged set, Bar E).

---

### 3. The line review

#### 3.1 `Enable` against §1.2

The signature is the packet's, in the packet's order: `type t` abstract, `high`,
`low`, `changes ~initial`, `value_at ~cycle`, `change_cycles`, `report`. Nothing
added, nothing renamed, nothing widened.

The implementation is correct on three points I checked rather than read:

- **`changes`' construction guard is complete against its own docstring.**
  `check` threads `prev_cycle : int option` and `prev_value : bool` from
  `(None, initial)`, so the first entry's redundancy test is against `initial` —
  the case a fold over adjacent pairs would miss. Positivity (`cycle <= 0`),
  strict ascent (`cycle <= pc`) and already-in-force (`Bool.equal value
  prev_value`) are all three present and all three raise.
- **`value_at` is correct *because* of the constructor, and the comment says
  so.** The left fold keeps the last entry at or before `cycle`; that finds the
  value in force only if `changes` is ascending, which `changes` enforces and
  `high`/`low` satisfy vacuously. The dependency is stated at the definition,
  which is where a later editor will break it.
- **`value_at` is total on the value the guard needs.** The guard calls
  `value_at ~cycle:(cycle - 1)` only under `if cycle = 0 then true else …`, so
  no negative cycle is ever queried, and the pre-run value is `true` per §1.4 by
  construction rather than by accident.

#### 3.2 The pre-scan against §3

Three properties, each checked in the source:

1. **DRIVEN words.** `Xgmii_word.start_lane (word_at ~cycle)`, where `word_at`
   is `run`'s own local — the `?word_at` override when given, `Arrival.word_at`
   otherwise — and is the identical binding `drive` uses. `Arrival.start_cycles`
   is not referenced in `run` at all. This is B4's whole content and it is
   satisfied at the strongest reading: the guard cannot be blind at M03-N4,
   because it reads through the exact seam M03-N4's start character arrives on.
2. **Refuse, not record.** `failwith` naming every offending cycle and its start
   lane, citing SPEC-M03 §6.3 item 7 and C-14.5. No sample is taken and no cycle
   is driven. The `Idle_injection` contrast is written into `bench.mli`'s `run`
   docstring in the worker's own words and the derivation survives the rewording:
   determinate-wrong-answer there, no-determinate-answer here.
3. **Position.** After `Arrival.check sched`, before the `drive` recursion is
   even defined — obligation 5's own "nothing is driven until the stimulus has
   been checked" position, as §3 requires.

`List.range 0 total` is `[0, total)`, so the walk covers cycles `0 … total - 1`
exactly, drain included.

#### 3.3 B10's by-construction claim, verified in code — and then measured

**In code.** `Enable.high = { initial = true; changes = [] }`;
`change_cycles t = t.changes`; the guard is entered only on `_ :: _`. An
`?enable`-omitted call therefore takes the `[]` branch, enters no new code, and
evaluates `word_at` exactly once per driven cycle — the pre-round count. The
claim is structural, not intentional, which is what §2 clause 4 demanded.

**The one real behavioural delta, and why it is a no-op.** `sample_cycle` now
executes `i.cfg_rx_enable := Bits.vdd` on every cycle of a default run, where
before `create` set it once and left it. Re-assigning a `Bits.t ref` the value it
already holds is not observable to Cyclesim: the port is read at each
`Cyclesim.cycle` and reads the same bits either way.

**And it is measured, which is better than argued.** If that drive had perturbed
the DUT by one bit on one cycle, the forty-eight pre-existing units — many of
which print — would have drifted, and CI step 8's
`git diff --cached --exit-code` would have failed with a `PROMOTION BLOCK`. It
passed. Bar C proves the *committed* expectations did not move; step 8 proves the
*observed* outputs did not either. B10 is closed on evidence, not on reasoning.

#### 3.4 The naming-axis third bullet — B6 on a mechanical proof

I stripped every comment from `bench.mli` at both trees and diffed the residue.
It differs in exactly three places:

```
> module Enable : sig … end        (nine lines, §1.2's signature verbatim)
>   ; enable : bool                 (sample's field)
>   -> ?enable:Enable.t             (run's argument: after ?word_at, before unit)
```

Nothing else. **The naming-axis bullet changes zero characters of executable
code**, and that is now a measurement rather than a reading. Placement: inside
the WO-0064 axis block, after the `_piece` bullet, before
`account_dropped_frame`'s docstring — §4's three "not"s each avoided.

**The six numbers, re-verified by me from `sc1 … sc6` and not from §4.**
`array_len = max 5 (t_idx + 1)`:

| | `t_idx` | declared | `a_delivered` | shortfall |
|---|---|---|---|---|
| sc1 | 10 | **11** | **8** | 3 |
| sc2 | 6 | **7** | **4** | 3 |
| sc3 | 2 | **5** | **0** | 5 |
| sc4 | 6 | **7** | **4** | 3 |
| sc5 | 10 | **11** | **8** | 3 |
| sc6 | 2 | **5** | **0** | 5 |

Declared 11/7/5 against received 8/4/0. **Agrees with §4 and with the landed
bullet.** The rule sentence, the `J-dv_lead-0113` §8 citation and the "not only
REQ-110's" clause are all present and correctly worded.

#### 3.5 The three runners against my own arithmetic

Derived from `requirements.md` §0.3/§0.5's lane mapping and REQ-004's
start-to-start figure, before the Return log's §(b) was read. **No disagreement
anywhere.**

- **Frame 100.** `84 × 100 + 8 = 8408`; `8408 / 8 = 1051` exactly, lane
  `8408 mod 8 = 0`. **Start cycle 1051, lane 0.** ✔
- **Frame 99 and cycle 1050.** Start ot `8324` → cycle 1040, lane 4; terminate
  ot `8324 + 72 = 8396` → cycle 1049, lane 4. Cycle 1050 spans ot 8400 … 8407,
  every one of them after frame 99's `/T/` and before frame 100's `/S/` at 8408
  — **all-idle, no start character.** **Change cycle 1050.** ✔ And the unit does
  not hard-code it: it computes `start_cycle frame_100 - 1`, asserts both
  figures, and asserts `start_lane (word_at ~cycle:1050) = None`. ✔
- **The 50/50 split.** `84n + 8 ≡ 4n (mod 8)` = 0 for even `n`, 4 for odd; 50
  even and 50 odd in `0 … 99`. **50/50.** ✔ Asserted against each frame's own
  `start_lane` field *and* against `start_lanes`' membership — two instruments,
  as §5.1 asked. ✔
- **Frame 100's words.** `1051 + 3 + m`, `m = 0 … 7` = **1054 … 1061**;
  delivered extent `64 − 4 = 60 = 7 × 8 + 4` → final `tkeep` **0x0F**, `tlast`
  on that word only, `tuser` 0. ✔ All four asserted.
- **J3, lane 0.** `first_start` 8 → frame 0 start ot 8 → **cycle 1**, lane 0;
  frame octets ot 16 … 79; `/T/` at ot 80 → **cycle 10, lane 0**; frame 1 start
  ot 92 → **cycle 11**, lane 4. ✔
- **J3, lane 4.** `first_start` 12 → frame 0 start ot 12 → **cycle 1**, lane 4;
  frame octets ot 20 … 83; `/T/` at ot 84 → **cycle 10, lane 4**; frame 1 start
  ot 96 → **cycle 12**, lane 0. ✔
- **Frame 0's words, both lanes: `1 + 3 + m` = cycles 4 … 11.** The coincidence
  §5.4 rests on is real, and it is asserted rather than assumed. ✔
- **J3's change cycle 5.** Spans ot 40 … 47 — inside frame 0's own octets at both
  lanes (frame offsets 24 … 31 at lane 0, 20 … 27 at lane 4) — and
  `5 ∉ {1, 11}`, `5 ∉ {1, 12}`. ✔ Asserted strictly-inside **and** not-a-start
  from `start_lane`.

**Three further readings I made that the packet did not ask for:**

- **The J3 accounting slices are correct, and for a reason worth naming.**
  `account_clean_frame` maps `delivered_samples` of *whatever list it is handed*
  into `Latency.frame_out`, and its own docstring says a multi-frame row calls it
  once per frame. So the reference bench must be fed per-frame slices — it is —
  while the disabled bench and J1/J2 may be fed the whole run, because in those
  runs only one frame delivers. All five call sites are right on that axis.
- **Two frames at two different start lanes on one bench do not break
  `is_constant`.** `Octet_time.Latency.is_constant` is *"every front-offset class
  has a single L"* — per class, not one L overall — so J3's reference bench
  (frame 0 at one lane, frame 1 at the other) is conformant by the monitor's own
  definition. I checked this because it is the one way §5.4 item 2 could have
  been unwritable as specified.
- **The cycle-0 transition is exercised, not merely legal.** J1/J2 build
  `changes ~initial:false [ (1050, true) ]`, so `change_cycles` is non-empty and
  the guard's walk *does* evaluate cycle 0 against the pre-run `true` — §1.4's
  "a derivation to check, not a convention to adopt". It passed in CI, which
  confirms cycle 0 carries an idle word at `first_start` 8. §6.2 records what
  this does **not** cover.

---

### 4. The four review-first items, adjudicated

#### 4.1 The `%`-class residue — **DISCHARGED, and the worker was right about its own limit**

The self-catch was correct: `%` is not bound in this codebase's scope, `Int.rem`
is the idiom everywhere, and `ocamlc -stop-after parsing` stops before name
resolution and cannot see the difference. The honest flag — *"cannot rule out a
second instance of the same class"* — was the right thing to write, and I am
closing it rather than repeating it.

**Closed two ways.**

1. **My own sweep.** Every `%` character in `test_m03_j.ml` is a ppx extension
   point: `let%expect_test` ×3 and `[%expect {||}]` ×3, six in total, zero
   arithmetic uses. `Int.rem terminate_ot0 8` at `:408` is the repaired site and
   is the house idiom. I also resolved every qualified path in the file by hand
   against its `.mli` — `Arrival.{is_clean,check,frames,start_cycle,start_lanes,
   word_at,terminate_octet_time}`, the `frame` record's `octets` and
   `start_lane`, `Frame.{stress_frame,delivered,sequence_of}`,
   `Xgmii_word.start_lane`, `Stream_word.{tvalid,tkeep,tlast,tuser,octets}`,
   `Conservation_monitor.frame_in_exempt`, and `Bench`'s own eleven — with no
   unresolved name.
2. **The compiler, which is the instrument that actually closes the class.**
   CI's `dune build @default` succeeded at `e4df986` (§1). Since this directory
   is reachable by no other compiler in this repo, that step is the first and
   only full name resolution the file has had, and it passed. A hand sweep can
   miss one; that step cannot.

**The lesson is banked and I second it.** `J-tb_writer-0026`'s harvest candidate
— *a syntax-only checker's silence is not evidence of binding, and the only
same-stage instrument is comparison against a corpus of code known to run* — is
LH2-g as claimed and is the correct generalisation of this incident. It is also
this round's best argument for why ADR-0005's "CI is the adjudicator" is a
structural rule and not a convenience.

#### 4.2 J3's `List.take`/`List.drop` — **CONFIRMED intended, no repair**

It is my own instruction. §5.4 item 3 says *"use `delivered_samples` on each run
and compare the lists"* and rules `split_at_first_tlast` out by name and by
precondition; slicing the reference run's 16 delivered words 8/8 is the reading
of that sentence, not an avoidance of a tool.

**And the instrument self-tightens, which is why the slice is safe.**
`tuple_equal` compares `tlast` element by element, so a reference whose first
eight words were *not* frame 0's — a `tlast` anywhere but index 7 — fails the
comparison rather than passing it. The 16-word count, the 2-`tlast` count and the
full-run octet equality bound it from the other side. A strengthening exists
(assert the reference's index-7 word carries `tlast` directly) and is **not**
commissioned: it is a second instrument for a fact the first already convicts on,
and §9's rule about unverifiable review-time edits applies.

#### 4.3 The M03-J2 honest-kill comment — **CORRECT, B8 clear**

`test_m03_j.ml:280–296` does three things and no fourth: it names the stale class
and says the stimulus does not separate it, with the reason (the enable is 1 for
the whole of frame 100's admitted extent, so a continuously-sampling design
truncates nothing); it names the reachable class (a design that refuses the first
frame after a re-enable — a latch to a frame boundary that never arrives, or a
settling requirement longer than one cycle); and it grounds that class in §4.3's
*"at least one cycle after"* plus the tightest-legal placement at 1050/1051. It
claims no more than the assertions below it check. The file docstring's *"What
this file does NOT claim"* section says the same at the top, where a reader meets
it first. This is the disposition §6 asked for, executed without over-correcting
into the opposite error.

#### 4.4 The 44-vs-19 count — ruled at §5.

#### 4.5 The self-flagged Bash grep — **no finding**

One read-only `grep -n` before the tool boundary was read as absolute; every
count re-derived with the Grep tool afterwards; both agreed; no file touched.
Disclosing a boundary deviation that changed nothing is the behaviour this
protocol wants, and I am not going to price it as a defect. Recorded here so the
auditor sees it adjudicated rather than unmentioned.

---

### 5. The 44-vs-19 ruling — **both wrong; the figure is 45**

**Measured, at `e4df986~1`, over every `.ml` in `test/xgmii_rx_64/`:** 46 lines
carry `~drain`, of which one (`bench.ml:176`) is `run`'s own definition.
**45 pre-existing `Bench.run` call sites.** `~drain` is a mandatory labelled
argument, so it appears at every call site and at no non-call site; I checked
every `run` occurrence that lacks it, and all are prose.

| File | sites | | File | sites |
|---|---|---|---|---|
| `bench.ml` (`run_directed_lengths`) | 1 | | `test_m03_f.ml` | 4 |
| `test_m03_a.ml` | 2 | | `test_m03_g.ml` | 8 |
| `test_m03_b.ml` | 6 | | `test_m03_h.ml` | 4 |
| `test_m03_c.ml` | 3 | | `test_m03_i.ml` | **8** |
| `test_m03_d.ml` | 3 | | `test_m03_n.ml` | 1 |
| `test_m03_e.ml` | 4 | | `test_m03_structural.ml` | 1 |
| | | | **total** | **45** |

**My 19 was true, and went stale.** I counted the history: the figure was 7 at
`WO-0038`, 11 at `WO-0040`, 14 at `WO-0043`, and **exactly 19 at `8e040f0`
(`WO-0047`, family F, 2026-08-03)** — then 25, 27, 31, 38, 41, 45. So §2
clause 2's number was measured once, was correct when measured, and was carried
forward through **eight** rounds without being re-measured. That is the
left-standing-summary defect this very directory's `dune` header exists to warn
about, committed by me, in a packet whose §12 tells its executor that *"a number
taken on trust is"* the defect. **§2 clause 2's "19" is struck: the figure is 45
at `e4df986~1` and 50 at `e4df986`.**

**The Return log's 44 is one short, and the miss is instructive.** Its pattern
was `run (bench|baseline_bench|overlay_bench) (sched|inj_sched)` — it constrains
the *schedule* argument's name as well as the bench's, and so misses
`test_m03_i.ml:1707`:

```ocaml
  let baseline_samples = run baseline_bench baseline_sched ~drain:8 () in
```

`baseline_sched` is in neither alternative. The measurement was honest, fresh and
reported as a disagreement exactly as §9 bar 2 asks; it was narrowed by a regex
that encoded an assumption about naming. **`~drain` is the invariant to count
on** — it is mandatory, it is at every call site, and it names nothing.

**What it changes: nothing in the round.** The compatibility argument is that
`?enable` sits before the terminal `unit` and every existing site applies `()`,
so the optional argument is erased and defaults at every one of them. I checked
all 45 lines: every one ends in `()` or `() in`, none names `?enable`, and none
partially applies `run`. The argument holds identically at 19, 44 or 45 — and CI
compiling all 45 unchanged is the proof that outranks all three counts.

---

### 6. Findings against my own packet

Five, none of them the worker's, all recorded because a packet that is wrong in a
way its executor could not have caught is worse than one that is wrong in a way
it could.

#### 6.1 `Enable.report` and `Enable.low` are specified-but-unused, and §1.3(d)'s stated ground is falsified by §5.5

Neither `Enable.low` nor `Enable.report` is referenced anywhere in `test/**`.
That is not the worker's doing — both are in §1.2's signature, and it built the
signature it was given.

But **§1.3(d) rejected the closure shape partly on the ground that *"a closure
has no `report`: the J-rows' expect blocks need to show the window they drove"* —
and §5.5 of the same packet mandates that all three expect blocks stay empty.**
The two sentences cannot both be right, and §5.5 is the one that governed. The
shape decision still stands, on **(R-b)** alone: five call sites each
hand-writing `fun ~cycle -> cycle >= k` with five hand-computed `k`s is the
`RV-0057` Finding 1 / `RV-0062` FINDING B-1 defect class, and a shared `Enable.t`
with a construction check is what closes it. That half was load-bearing and
remains true. The `report` half was not, and I should not have written it.
`report` keeps its place as a diagnostic for a future row and for failure
messages; it is not evidence for the shape.

#### 6.2 The cycle-0 hole — a real gap in **my** guard specification: harmless today, reachable at N4

`Enable.low` has `changes = []` — §1.2's own docstring says *"`high` and `low`
both return `[]`"* — so `change_cycles Enable.low` is empty and **the pre-scan is
not entered for it**. But `low`'s `initial = false` means there *is* a 1 → 0
transition between `create`'s reset drive and cycle 0, and §1.4 says the guard
*"checks it like any other change"*. It does — but only when the schedule was
built by `changes`. Built by `low`, the same transition is invisible to the
guard.

**Today this is unreachable and harmless.** `frames_at` fixes `first_start` at 8
or 12, so the first start character is always in cycle 1 and cycle 0 is always
idle; and no row uses `Enable.low`. **It becomes reachable the moment a row
combines `Enable.low` with a `?word_at` override that places a start character in
cycle 0** — which is M03-N4's own mechanism class, and M03-N4 is the next round.

**The defect is in §2 clause 4 and §3's entry condition, which I wrote, not in
the code, which implements both verbatim and correctly.** The worker had no
licence to widen the entry condition and was right not to. It is carried into
`WO-0068` as a named item (§10 item 3) with two admissible repairs to choose
between on a derivation: give `change_cycles` the cycle-0 entry its own docstring
implies when `initial = false`, or enter the pre-scan on
`change_cycles ≠ [] || not initial`. I am not choosing here, because the choice
belongs with the round that first drives the combination.

#### 6.3 Bar B's enumeration is complete on mechanism, silent on multiplicity

My re-run yields **15** added extraction-lines, not 10: the Return log's table
lists ten *distinct* strings and does not list `"cycle "` (×4 — three in
`Enable.changes`' messages, one in `Enable.report`) or `"\n"` (×2 — the `~sep` of
`Enable.report` and of the guard's `failwith`). Every one of the fifteen belongs
to one of the two mechanisms the table names, so the bar's substance — *one
justification per added literal* — is met; the accounting is not
literal-for-literal. Also noted for the next executor of this bar: the guard's
own long message spans three source lines with `\` continuations and is **not**
captured by the line-based extractor at all, on either side. The bar's real
content is the absence of `<` lines, and there are none.

#### 6.4 §2 clause 3 says "the ten `test_m03_*.ml` files"; there are eleven

`test_m03_structural.ml` matches the glob. Bar A was run over all eleven and is
empty at all eleven. Clerical, no consequence, recorded because this verdict is
already striking one uncounted number and it would be poor form to leave a second
standing.

#### 6.5 One asymmetry that is the packet's, and is not a defect

J3's **reference** bench is accounted (`account_clean_frame` ×2, §5.4 item 7);
J1's **control** bench is not (§5.2 items 5–6 ask for delivery and provenance
assertions and `assert_monitors_clean`, not accounting). So on the control bench
the protocol and strobe monitors are live and the conservation and latency
monitors are vacuously clean. The worker followed both instructions exactly.
Recorded so that `assert_monitors_clean control_bench` is never read as evidence
of a conservation result it does not carry — the control's job is anti-vacuity
for the *schedule*, and it does that job.

---

### 7. The count, by measurement

**Unit inventory: 48 → 51.** Measured at both trees by `let%expect_test` count —
48 across the eleven pre-existing files at `e4df986~1`, 51 at `e4df986` — and
independently by `tools/dv_checks.sh`, which the worker could not run and which
reports `51  test/xgmii_rx_64/ (the M03 bench)` and `131  test/
(repository-wide)`. `test_m03_j.ml` contributes 3.

**Row-discharge census: 43 → 46**, by the trailing-digit-boundary titles method
(the one `dv_checks.sh` tells you to quote). Measured: the script reports **46**
boundary / 47 naive at `e4df986`, with `M03-M1` over-discharged by the naive
matcher only; and the string `M03-J` occurs **zero** times in every `.ml` in this
directory at `e4df986~1`, so the three new titles are the entire delta.
**43 → 46.** The two declared adjustments (−1 for `M03-A4`, a NO-ASSERT row named
in a title; +1 for `M03-F5`, discharged by citation) net to zero, against a
denominator of **78** declared row ids.

Provenance for both figures: `bash tools/dv_checks.sh`, run by me at this tree.

---

### 8. Fold-in 3 — the rider falls due, and here is where it lands

`WO-0066` §10 item 2 dated fold-in 3 — *cross-checking frame A's delivered
**content**, not only its count, at `M03-N2`'s four delivering sub-cases* — to
the first round that opens `test_m03_n.ml`, with the fallback that if none were
scheduled by the time family J returned, it rides family J's `RV-`. **The
fallback fired, correctly, and this verdict is where it is ruled.**

**The gap, measured.** At the four delivering sub-cases (sc1, sc2, sc4, sc5 —
`a_delivered` 8, 4, 4, 8), `run_subcase`'s delivering branch asserts frame A's
single delivered word's **cycle**, **`tkeep`**, **`tlast`** and **`tuser`[0]**.
`tkeep` pins the *count*. **No assertion anywhere compares the delivered octets'
values** against frame A's own array. The fold-in is undischarged exactly as
`WO-0066` described it, and the two zero-delivered sub-cases (sc3, sc6) have
nothing to compare, so the population is four.

**Ruling: it lands as a named, dated, BOUNCE-backed item in `WO-0068`, the
N-completion round — not as a repair by me in this verdict.** Three grounds, in
order of weight:

1. **`WO-0066` §13 names *"the assertion order inside `run_subcase`"* as sealed
   content of the family-B/N mutation campaign, whose scorecard cells are
   message-level.** Inserting an assertion into that runner changes which message
   a mutant raises first. That is not a change to make as a review-time
   convenience; it belongs in a packet that states the effect and prices it.
2. **I cannot compile or run anything at this tree.** There is no `dune` in this
   container (ADR-0005 — opam downloads are blocked; CI is where OCaml
   correctness is established). An edit by me to a landed, green file would ship
   unverified into a commit whose whole value is that CI is green at it. A
   reviewer who reddens the tree to discharge a documentation-grade debt has made
   the trade backwards.
3. **The primary carrier is no longer unscheduled.** The fallback's own condition
   was *"if no such round is scheduled by the time family J's capability round
   returns"*. It is scheduled — in §10 below, as the very next round. The
   fallback fired because of the state at the moment family J returned; the right
   response is to hand the debt to its primary carrier now that the carrier
   exists, not to discharge it with the weaker instrument.

**And because "an undated carrier is how a debt becomes a habit" is `WO-0066`'s
own sentence and it is right, this is the debt's LAST carrier.** In `WO-0068`,
fold-in 3 is a **BOUNCE condition**, not a line item — the round does not land
without it — and there is no further fallback. To remove any re-derivation from
the executor's path, the instruction is specified here:

> At `run_subcase`'s delivering branch (`sc.a_delivered > 0`), in the `| [ s ] ->`
> arm, after the existing `tuser` assertion: compare
> `Dv_monitors.Stream_word.octets s.out` against the **first `sc.a_delivered`
> octets of frame A's own declared array** — the array the sub-case builds as
> `List.init array_len …`; **not** `Arrival.delivered` and **not**
> `Frame.delivered`, both of which strip an FCS this aborted frame never reaches.
> Assert list equality under `Int.equal`, and on failure name the sub-case, the
> expected extent and the observed length. `Stream_word.octets` returns exactly
> the `tkeep`-kept octets, so the lengths agree by the `tkeep` assertion
> immediately above and the new check is a pure content check — which is the
> whole of what fold-in 3 asks for. State in the packet that this changes
> `run_subcase`'s assertion order, and that the `WO-0066` seal's message-level
> cells are read against the pre-change order.

**Fold-in 3 leaves my carried list when `WO-0068` lands, and not before.**

---

### 9. Reviewed repairs — **none**, and that is a conclusion

The charter permits reviewed trivial repairs and this verdict makes none. Every
candidate I found (§4.2's index-7 `tlast` assertion; §6.3's literal accounting;
§8's fold-in) is a **strengthening or a clerical note, not a defect** — and a
strengthening rides a packet with a derivation, not a reviewer's edit. The
decisive constraint is the same one §8 turns on: there is no `dune` at this tree,
so any edit I made to `test/**` would land unverified against a commit whose CI
is currently green across every step. I am not trading that for tidiness.

**One charter duty I could not perform, stated rather than skipped.** Charter §3
requires me to spot-check a worker bench by hand-mutating the design in a scratch
tree and confirming the bench fails. No local toolchain, so no mutation run:
family J is **not** mutation-scored and this verdict claims no kill. What stands
in its place is in-bench and structural — J1 carries the mandatory `Enable.high`
control run (B7), whose whole purpose is to make a vacuous schedule fail; J3
carries a reference run that must deliver two frames where the disabled run
delivers one; J2 carries a provenance assertion that the delivered frame is frame
**100** and not merely *a* frame. Each unit holds a witness against its own
vacuity. Family J's mutation scoring belongs to the next campaign round after the
outstanding ASSERT rows close, and is recorded in §11 so it is carried rather
than assumed.

---

### 10. What I commission next — the N-completion round (`WO-0068`)

Sequenced by my own §8 and unchanged by anything found here: **M03-N4 beside
M03-N1 in `test/xgmii_rx_64/test_m03_n.ml`**, reusing `M03-N2`'s landed
derivation of SPEC-M03 §6.1's six-row report table rather than building a second
reading of it in a second file. The capability this round landed is what makes N4
writable, and it is now landed and green.

Its scope, named now so the packet is written against a fixed list:

1. **M03-N1 and M03-N4**, both ASSERT, in `test_m03_n.ml`.
2. **Fold-in 3**, per §8 — **a BOUNCE condition of that round**, with the
   instruction quoted there.
3. **§6.2's cycle-0 guard gap** — the round that first drives `?enable` together
   with `?word_at` is the round that must close it, with the choice between the
   two admissible repairs made on a derivation and stated.
4. **`Enable.report`'s standing** — §6.1 — either used, or its justification in
   `bench.mli` corrected to what it actually is.

**The count under that round, stated as a prediction to be measured and not
quoted:** inventory 51 → 53 if N1 and N4 land as one unit each, census 46 → 48 by
the boundary method; both to be re-measured with `tools/dv_checks.sh` at that
tree, never carried from here. §5 of this verdict is the reason that sentence is
phrased that way.

Also owed and unchanged: the `AP-xgmii_rx_64.md` plan edits of §11 — M03-J2's
Kills cell (§6's finding, history kept and ground replaced), M03-J1's Observable
clause, the §7 machinery row for the enable schedule, and `J-dv_lead-0118`
item 5's two clerical residues — in the next round that opens that file, mine and
not an executor's.

---

### 11. Carried after this verdict

- **Struck by this verdict**: the `_frame`/`_piece` naming-axis cell (§4 of the
  packet — landed, and verified comment-only); family J's two-deferral clock,
  discharged; **fold-in 3's undated state** — it now has a bounce-backed carrier
  and leaves the list when `WO-0068` lands.
- **New, mine**: §6.1 (`report`'s falsified justification), §6.2 (the cycle-0
  guard gap), and §5's struck count — the last of which is the second
  left-standing-summary defect this programme has paid for, and the first I have
  committed myself.
- **New, named rather than carried**: family J is not mutation-scored; no `SO-`
  is offered or implied by this ACCEPT.
- **Unchanged**: `run_i2_member`'s citation exception; `WO-0061` §8 bound 1's
  `tkeep` half; **N-1**; **F-1** with architect_docs_lead; the auditor's ledger
  disposition on `BUG-0003`; **B-2**, **B-3**, **B-4**; **DVC-1** in the next
  round that opens `tools/`; T8's strobe-multiplicity question with
  architect_docs_lead.

**Verdict: ACCEPT.** Landing evidence is `build` run `30980439774` and
`journal-check` run `30980439829`, both **success** at `e4df986`, with the
promotion gate clean.
