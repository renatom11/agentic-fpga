# WO-0085: M04 cfg_ifg gap axis — commission the configuration-coverage benches (M04-F3, M04-F7) that close WO-0084-S2

- **State**: DRAFT — the number is a **PLACEHOLDER**. The orchestrator allocates
  the next free `WO-` number at commit (PROTOCOL §3); `WO-0085` is the next free
  id measured at this tree (`ls agents/handoffs | grep -c WO-0085` → 0). If the
  orchestrator allocates a different number, the filename and every internal
  self-reference (`WO-0085` appears at the title, this State line, §7 T-8's
  citation in `AP-xgmii_tx_64.md`, and the `J-dv_lead-0197` change-log row) move
  together.
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: SPEC-M04 §6.1 (the gap paragraph and the identity
  `g = ⌈(cfg_ifg + t)/8⌉` words, gap `8g − t` octets), §9 (the abort word and
  *"the gap is then served from that terminate character"*), §4.2/§4.3
  (`cfg_ifg`), requirements.md §9.1 (`cfg_ifg ≥ 12` — values below 12 SHALL NOT
  be driven); **REQ-204, REQ-206, REQ-802**; `AP-xgmii_tx_64.md` rows **M04-F3**
  and **M04-F7** (row TEXT only), the §4 arithmetic identity, the §2 standing
  obligations, and §7 item **T-8**.
- **Deliverables** (all inside `test/**`, tb_writer's write scope):
  1. **The `cfg_ifg` knob (T-8).** A way for a unit to drive `cfg_ifg ≠ 12`
     through `test/xgmii_tx_64/bench.ml`'s driver, with the `Tx_decoder`
     constructed `~ifg:<the driven value>` so its standing REQ-204 gap-legality
     arm tracks the configured gap rather than the hard-wired 12. The **default
     path (`cfg_ifg = 12`) must stay byte-identical** so the 39 discharged rows
     and every pre-existing unit are unperturbed — `git diff` on their
     `[%expect]` blocks must be empty. `bench.ml`'s own run-length note warns
     that a round changing `cfg_ifg` must **re-derive** the `g_max` cycle bound;
     do that from the identity, per member.
  2. **A unit discharging `M04-F3`** — the normal-gap sweep.
  3. **A unit discharging `M04-F7`** — the abort-gap sweep.
  4. **The `M04-F6` correction (WO-0084-S1's second site).** In
     `test/xgmii_tx_64/test_m04_f.ml`, strike/rewrite the `M04-F6` comment and
     failure-message that quote *"16 is one octet from conformant"*: the abort
     defect the row's `= 15` assertion actually kills is a **whole-word** error
     (a recorded gap of 7 or 23), and **16 is not a gap this decoder can record
     after an abort** — every abort gap is `8k − 1`, i.e. `≡ 7 (mod 8)`. Cite
     `WO-0084-S1` and `AP-xgmii_tx_64.md`'s corrected `M04-F6`. This does not
     change the assertion (`= 15` stands); it corrects the explanatory text so
     the failure path cannot itself quote the unreachable figure.
- **Definition of done**: `M04-F3` and `M04-F7` asserted and green under
  `dune runtest`; `git diff --exit-code` clean (no unpromoted / non-deterministic
  output); the `cfg_ifg = 12` path unchanged for every pre-existing unit; the
  `M04-F6` message corrected; a worker journal entry appended (Trigger carrying
  the spawn short-id); no doc impact beyond `test/**`.
- **Context provided** — the two row texts, the identity, and the bench's public
  interface. **RTL source is DELIBERATELY OMITTED**:
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` is NOT attached and MUST NOT be
  opened (PROTOCOL §10; DV independence — tests derive from spec, never from
  RTL). Every expected value below is derived from SPEC-M04 §6.1's identity, not
  from the design; a leaked-RTL violation would be visible in the worker's
  journal Inputs. The interface files you MAY read: `test/xgmii_tx_64/bench.mli`,
  `test/xgmii/tx_decoder.mli`, `test/xgmii_tx_64/test_m04_f.ml` (the family-F
  units, for style and to site the M04-F6 correction), and `AP-xgmii_tx_64.md`.
  - **M04-F3** (already an ASSERT row in the plan — you are giving it its bench,
    not authoring it): Stimulus — `cfg_ifg ∈ {12, 13, 16, 20, 255}`, each with a
    normal frame terminating at `t = 0`, the value stable from well before the
    terminate character. Observable — `g = ⌈cfg_ifg/8⌉` words, gap `8g` octets:
    **16, 16, 16, 24, 256**. Kills — a design reading `cfg_ifg` as a *word* count
    (at 20 it serves 160 octets); a design ignoring `cfg_ifg` and hard-wiring 16,
    which the default hides (12, 13 and 16 all give 16, so the default cannot
    distinguish a configurable design from a fixed one, and **20 is the smallest
    member that can**); a design saturating an 8-bit accumulator at 255.
  - **M04-F7** (added this round): Stimulus — an underflowed frame (family G's
    stall stimulus; §9's terminate character is the `/T/` at **lane 1**, `t = 1`)
    followed by a normal frame, swept over `cfg_ifg ∈ {12, 16, 24}`, each value
    stable from well before the abort word. Observable — `Tx_decoder.gaps` has
    **exactly one** abort-gap entry (assert the list length first), of
    `g = ⌈(cfg_ifg + 1)/8⌉` words and `8g − 1` octets: **15, 23, 31**; next start
    character in lane 0. Kills — the IC-10 / ABORT-GAP-FROM-`/E/` design that
    measures from the `/E/` in lane 0 (`t = 0`): it records `8·⌈cfg_ifg/8⌉ − 1` =
    **15, 15, 23**, identical to conformant at `cfg_ifg = 12` and a **whole word
    short** at 16 and 24 (15 vs 23, 23 vs 31); and a design hard-wiring the abort
    gap. Assert the gap **exactly** (`= 15/23/31`), never `≥ cfg_ifg` — a
    `≥`-only check is green against the defect.
- **Out of scope**: RTL of any kind; the abort **word shape** (family G's rows
  own `/E/`/`/T/`/`/I/` placement — do not re-assert it here); the controllable-
  handover machinery (`T-7`, family H's — NOT needed, abort-then-normal is
  `run_stream` / `run_scheduled`'s existing shape); the DIC / average-gap
  question (`M04-F4`/`M04-F5` own it); `WO-0083`'s stage-2 revision items.

## Task

Build the `cfg_ifg` axis for M04. Two coverage gaps a mutation campaign
(`WO-0084`) demonstrated are closed by one instrument: the suite never drove any
`cfg_ifg` but 12, so a *gap-ignores-ifg* mutant (`class-11`) survived the whole
campaign on the normal path, and its abort sibling (the sealed `IC-10`) could not
be scored at all. `M04-F3` and `M04-F7` are the plan's two rows for it; both need
the harness able to present a configured gap other than the default (§7 `T-8`),
which no committed producer can do today.

1. Add the `cfg_ifg` knob (Deliverable 1), keeping the default path byte-exact.
2. Write the `M04-F3` unit (normal gap, five members).
3. Write the `M04-F7` unit (abort gap, three members) — the abort stimulus is
   family G's stall producing a `/T/` at lane 1, followed by a normal frame; the
   discriminating members are `cfg_ifg ∈ {16, 24}` (the `/E/`-vs-`/T/` reading
   separates by a whole word there), with `cfg_ifg = 12` carried as the control
   that shows the class is invisible at the default.
4. Correct the `M04-F6` comment/message (Deliverable 4) — the `= 15` assertion
   stays; only the text that quotes *"16 is one octet from conformant"* is fixed.

Assert each list's **length first** (a two-gap run must not pass a one-gap
check), and assert the gap value **exactly**. Derive every cycle bound and gap
value from SPEC-M04 §6.1's identity per member — do not carry the `cfg_ifg = 12`
figures forward.

## Return / verdict log

(appended on RETURNED / ACCEPTED / BOUNCED, with journal-entry refs)
