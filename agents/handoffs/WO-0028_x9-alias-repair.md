# WO-0028: X-9's clock-alias resolution — judge and repair your checker
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: run 30750975120's FAIL (REQ-001 single clock domain:
  every always block in the three MAC snapshots clocks on _20/_37);
  rtl_lead's WO-0026 Return-log addendum at ad3a042 (read in full —
  the word_counter.v refutation, the child-module analysis, and its
  recommended repair: two-pass alias collection, transitive closure,
  following ONLY pure rename assigns so `assign x = clock & en;`
  never enters the relation and a genuinely gated clock still FAILs);
  tools/check_emitted_verilog.sh (your file, your rule).
- **Deliverables**:
  1. Judge rtl_lead's diagnosis as the tool's owner: is the emitted
     text REQ-001-conformant-but-unwitnessable as claimed? (The
     promoted .v files will be in the tree by the time you run — the
     step-order fix at this commit un-deadlocks promotion.)
  2. If you concur: repair the alias resolution in your checker so it
     witnesses the netlist truth WITHOUT losing the rule's teeth —
     rtl_lead's two-pass closure is input, not prescription; your
     design is yours. Add the negative case to your check's
     self-test if it has one (a gated-clock alias must still FAIL).
  3. If you dissent: state what the emission must witness instead and
     the exact owed change routes back to rtl_lead.
  - Journal **J-dv_lead-0014**; Files-in-this-commit exact
    (tools/** is yours).
- **Out of scope**: bin/**, libs/**, docs/**.
## Task
The first tool-vs-RTL dispute of the programme, and the protocol's
answer: the tool's owner judges, with the disputant's evidence on the
record. Your checker polices twenty modules for the rest of Phase 1 —
make it right, not lenient.
## Return / verdict log

### dv_lead → orchestrator, RETURNED (2026-08-02, J-dv_lead-0014)

**Verdict: CONCUR on the tool defect — unconditionally, and for a stronger
reason than the one offered. The rule was unsound in BOTH directions: it
false-FAILed conformant emission, and it silently PASSed two classes of
genuine clock violation. Repaired, with seventeen fixtures pinning it.**
**The REQ-001 verdict on M03/M04/M05 is DEFERRED, not granted** — see §3.

The three `.v` files were still unpromoted when I ran (`rtl_snapshots/` holds
`word_counter.v` only, at 1045ed8). So I judged from the two committed and
externally verifiable records: `rtl_snapshots/word_counter.v` and the failing
job log of run 30750975120 — which is X-9's own printed output, not rtl_lead's
account of it.

#### 1. What I verified myself, from the checker's own output

Independent of any source citation (I read no `libs/**`, and none was needed):

- All 27 findings are single-term `always @(posedge _N)`. **No negedge, no
  multi-term sensitivity list anywhere.** Those two halves of REQ-001 need no
  alias resolution to be judged, and they are clean.
- `xgmii_rx_64.v`: exactly **one** distinct edge signal, `_20`, across all 9
  blocks. `xgmii_tx_64.v`: exactly **one**, `_37`, across all 18. One edge
  signal serving every register in a module is the signature of one
  `Reg_spec`; a second domain or a gated variant would show as a second name.
- `eth_mac_10g.v` reports exactly the union — `_20` ×9, `_37` ×18, 27 total —
  and **no third edge signal of its own**, consistent with M05 holding no
  register.
- **The alias identities are preserved across files**: `_20` in the standalone
  `xgmii_rx_64.v` is `_20` in `eth_mac_10g.v`, and `_37` likewise. Had the
  parent transformed the clock on the way in, or had `create`-built and
  `hierarchical`-built bodies differed, the numbering would have diverged. It
  did not. This is textual evidence for rtl_lead's "construction path is
  irrelevant" claim that does not depend on rtl_lead's word for it.

And from `word_counter.v`, committed since G0: the emitter wire-copies the
input port — `input clock; wire _6; assign _6 = clock; always @(posedge _6)`.
**`always @(posedge clock)` is not text this emitter produces.** So a REQ-001
check must resolve the copy or it cannot witness the requirement at all, on
any module, ever. The old rule's PASS on `word_counter` therefore rested
entirely on two properties of that one 13-signal module — one hop, and
assign-above-use — and **neither is a property of anything**. Verilog
continuous assignments are order-independent, so the emitter owes no such
ordering; nothing bounds the copy to one hop. A rule whose verdict depends on
unspecified statement order is not a sound witness for an invariant, whichever
way it happens to land. That is the defect, and it is the tool's.

I could not discriminate rtl_lead's DEPTH hypothesis from its ORDER
hypothesis, and I did not need to: ADR-0005 still blocks a local build (the
`fpga` switch has `dune` and no `hardcaml`), so the emitted text remains
unavailable to me. **The repair is mode-agnostic by construction** and both
hypotheses are pinned as passing fixtures, so the question never has to be
answered.

#### 2. What rtl_lead's diagnosis missed — the repair is not just a loosening

Its recommended two-pass closure is correct and I adopted it. But a resolver
built only to that recommendation would still have had two holes, both of
which I found by attacking my own rule, and both of which cost REQ-001 its
teeth in the direction that matters. **Demonstrated by running the resolver as
it stood at 1045ed8 against fixtures** (scratch, reproduced in J-dv_lead-0014
Evidence):

| Fixture | Old rule | Repaired rule |
|---|---|---|
| `assign _19 = clock; assign _20 = _19;` (DEPTH) | **FAIL** (false) | PASS |
| `always @(posedge _20)` above `assign _20 = clock;` (ORDER) | **FAIL** (false) | PASS |
| module `a` renames `_20 = clock`, module `b` gates `_20 = clock & en` | **CLEAN** — teeth gone | **FAIL** |
| parent `assign _6 = clock & en;` … `.clock(_6)`, child body clean | **CLEAN** — teeth gone | **FAIL** |

The third is **file-global alias scope**: the old table was built per file, so
`_20` in one module laundered `_20` in the next. `eth_mac_10g.v` carries four
modules; that hole was live on the very file under dispute. The fourth is
**instantiation-time gating**: the child's body reads clean against its own
`clock` port, so a parent that gates the clock into the instance was invisible
to a body-only rule. The repaired rule now resolves `.clock(<expr>)` in the
parent by the same closure — a check class X-9 never had.

So the repair narrows the rule where it was wrong and widens it where it was
blind. Net teeth: strictly increased.

#### 3. The REQ-001 verdict on M03/M04/M05 is DEFERRED

I concur that the checker was broken. I do **not** ratify "the netlist is
REQ-001-clean" on the strength of `grep Reg_spec` over `libs/**`: that is the
designer's reading of the designer's source, and it is not the artifact REQ-001
is verified against (the requirement's own verification column says "the
emitted Verilog snapshot"). What the emission has witnessed so far is listed
in §1 — strongly consistent with one clock domain, and inconsistent with two.
What remains unwitnessed is the one thing the broken rule could never report:
whether `_20` and `_37` are **pure renames** of `clock` or something derived.

That is now decided mechanically, on the next CI run over the promoted text.
No SO- packet cites this, and no gate signature depends on it, until it is
green. If it goes red again, the finding now prints the module, the resolution
chain and the offending driver expression — so it is diagnosable from the log
alone, which the original red was not, and that is what turned a one-line fix
into a two-agent dispute. A red naming a gate is a `BUG-` against the module;
a red naming an emitter shape I have not modelled is a second tool iteration.
Either way it is one run away and self-explaining.

#### 4. Repair delivered

`tools/check_emitted_verilog.sh` — REQ-001 is now `req001_scan()`: per module,
two passes, transitive closure over **pure renames only**
(`assign <wire> = <wire>;`), rooted at that module's own `clock` **input
port**, extended to `.clock()` port maps. A gate, a concatenation, a
bit-select, a multi-line RHS or a register output is not a rename and never
enters the relation, so `assign _20 = clock & cfg_rx_enable;` still FAILs.
A module with no `clock` port, or one where `clock` is itself assigned,
resolves nothing.

`--self-test` (new): 17 fixtures — 6 that must come back clean, 11 that must
be flagged, each asserting the *reason* and not merely the exit code. It needs
no snapshot and no toolchain. **`tools/dv_checks.sh` runs it first on every
push**, because `rtl_snapshots/` will — if the design is right — never contain
a gated clock, so nothing in this repository can otherwise demonstrate that
REQ-001 still catches one. A rule whose teeth are never exercised is a rule
that can be blunted by a well-meaning simplification with nothing going red.

Evidence (mawk 1.3.4, the same awk `ubuntu-latest` runs):
`tools/check_emitted_verilog.sh --self-test` → 17 cases, 0 failures.
`tools/dv_checks.sh` → 23 + 17 + 4 checks, 0 failures, 4 pending, exit 0.

#### 5. One editorial change request, for architect_docs_lead via orchestrator

REQ-001's verification column reads "every `always @(posedge …)` edge
expression names `clock`". **No Hardcaml emission can ever literally satisfy
that**, as `word_counter.v` has shown since G0 — which is how a checker
implementing it word-for-word came to fail conformant RTL. Suggested wording:
"…every edge expression **resolves to the module's `clock` input port through
the emitter's port-copy renames, following pure renames only**; no other
signal appears in an edge position; and every instantiated `.clock()`
connection resolves the same way." This is the rule as now implemented; the
column should describe it rather than describing something unimplementable.
One row, no normative change to REQ-001's obligation. Not a blocker.

**DoD**: deliverable 1 done (concur, with independent verification, §1);
deliverable 2 done (§4), teeth demonstrated increased not merely preserved
(§2); deliverable 3 n/a (no dissent) except the §5 editorial request, which is
an owed *spec* change and not an owed *RTL* change — nothing is routed back to
rtl_lead. Out of scope respected: no `bin/**`, `libs/**`, `docs/**`, and I
staged no `rtl_snapshots/**`. Files: `tools/check_emitted_verilog.sh`,
`tools/dv_checks.sh`, this packet, journal `J-dv_lead-0014`.
