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
