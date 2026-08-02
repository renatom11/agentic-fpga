# WO-0032: M03 RTL conformance — every closure character at its own octet time
- **State**: ACCEPTED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis**: WO-0029's ruling on your WO-0024 §6 Q2 declaration
  (J-architect_docs_lead-0011 at 541ea43): reading (i) — every start
  and closure character is evaluated at its own octet time; the
  finding that the M03 RTL at f840475 is **non-conformant against
  REQ-102 and §10's REQ-102/REQ-110 hooks — all frozen since batch A
  and untouched by any pending repair** (dv's WO-0030 §7 item 4
  confirms this does not wait on the SPEC-M03 re-countersignature);
  dv's second independent ground (REQ-101: the one-closure reading
  gives one REQ-102 frame two different output streams at the two
  start lanes); ADR-0014 (confirms your other declared reading).
- **Deliverables**:
  1. Repair libs/hardcaml_ethernet/src/xgmii_rx_64.ml so a word
     carrying multiple start/closure characters evaluates each at
     its own octet time per REQ-102's third sentence — e.g. `/S/`
     lane 2 + `/T/` lane 5: the abort AND the terminate both take
     effect, in octet order. Your original declaration (WO-0024 §6
     Q2) documented the single-closure reading precisely; that
     precision is what made the ruling cheap — now implement the
     ruled reading with the same care.
  2. Note that SPEC-M03 §6.3 gained item 8 at 541ea43 (excludes only
     the same-strobe-name-same-cycle unrepresentable case) and §6.1
     gained consequence text currently under a bounded R1/R2 repair
     (WO-0031) — neither changes REQ-102's obligation; if you find
     they change YOUR obligation, return the question instead of
     guessing.
  3. Self-review per your charter; expect-test updates are yours
     where they are YOUR tests (test/** benches remain dv's — do not
     touch). State in the Return log the expected CI outcome: the
     determinism step will go red with changed rtl_snapshots/
     xgmii_rx_64.v and eth_mac_10g.v as the diff — the promotion
     block (build.yml) is now the standard promotion source; I
     promote verbatim, second run green.
  4. If the fix changes M03's cycle arithmetic (the m + 3 formula's
     instances, front-offset constants), say exactly which observable
     constants moved — dv's attack rows M03-L2/L3 pin them.
  - Journal next id in your sequence (J-rtl_lead-0005 expected);
    Files-in-this-commit exact.
- **Out of scope**: test/**, tools/**, docs/** (spec questions
  return as questions); bin/generate.ml unless emission itself must
  change (it should not); committing.
## Task
The text convicted the implementation, exactly as this program is
built to do. Close the gap the same way you built the module:
precisely, with the deviation named in your Return log.
## Return / verdict log

### RETURNED — rtl_lead, 2026-08-03T07:15Z (spawn `WO-0032/2026-08-03T05:45Z`)

- **State**: ISSUED → **RETURNED** · **Journal**: `J-rtl_lead-0005`
- **Files**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` only. `.mli`
  byte-unchanged (no interface moves, REQ-010 identity holds);
  `bin/generate.ml`, `rtl_snapshots/**`, `top/**` untouched.

#### 1. The mechanism: three octet-time epochs, two report paths

The old decode had **one** closure search per word, over lanes
`≥ search_from`. The repair replaces it with **three** searches, one per
frame whose octet times the word can contain:

- **epoch A** — the frame open on entry (`Preamble`/`Frame`), searched over
  all eight lanes;
- **epoch B** — a frame opened by `/S/` in lane 0, searched over lanes 1…7;
- **epoch C** — a frame opened by `/S/` in lane 4, searched over lanes 5…7.

REQ-101 begins a frame in lane 0 and lane 4 only, so three is exhaustive.
Each epoch is closed by the lowest closure character **above its own opening
octet time** — which is what §6.1's "evaluated at its own octet time, against
the frame open at that octet time" reduces to on a 64-bit datapath. `/S/`
lane 4 + `/T/` lane 6 in a word with a frame open now yields *both*: epoch A
aborts at lane 4 (REQ-110, four delivered octets in dv's M03-R1 witness) and
epoch C is closed by the `/T/` at lane 6 with zero delivered octets
(REQ-107). Under the old code the `/T/` was invisible and epoch C ran on.

The fact that keeps this cheap: **a frame opened inside a word covers no
frame octet in it** — eight preamble octets from the `/S/` inclusive, eight
lanes. So only epoch A contributes octets, and coverage, alignment, `tkeep`,
CRC sequencing and the FCS-straddle lookahead are structurally unchanged.
Epochs B and C always deliver zero octets, so §9 pins their report to exactly
two cycles later, and their report path is **two fixed register stages** —
no ageing, no consumption decision. Their four-bit strobe vectors are ORed
(different names both pulse, per §0.6 and §6.1's consequences; the same name
gives one high cycle, which is precisely §6.3 item 8's excluded stimulus).
The existing three-age record channel now carries epoch A alone and is
otherwise untouched.

Consequences elsewhere in the module, each a simplification: `search_from`,
`start_here`, `opens_now`, `restart_now` and the count/CRC base-selection
muxes are gone, replaced by one `begins` (= an in-word epoch survived to lane
7) that reloads the octet count and the CRC seed and drives `to_preamble`.
`begins` carries the `cfg_rx_enable` and `clear` gates, while epoch A's
closure search tests `is_start` **ungated** — ADR-0014's admission-versus-wire
distinction expressed in two lines.

#### 2. A second REQ-102 gap found while implementing, and closed

REQ-102's third sentence routes **any other** control character in a preamble
position to REQ-105 — `/I/` and `/Q/` included, which is the M03-N3 ruling
§6.2's `Preamble` row now carries. The RTL at `f840475` treated every
non-`/S/`/`/T/`/`/E/` control lane as the REQ-016 hold wherever it fell, so an
idle in a preamble position was absorbed and the frame ran on: the same defect
family as the one this packet names, at a different character. It is closed
here — `other_ctl` masked by the epoch's preamble positions is a closure,
elsewhere it is the hold — because §10's REQ-102 hook commissions the frame
(`one frame with an idle character in a preamble lane`) and because repairing
one half of REQ-102's third sentence and leaving the other would be a silent
deviation. Named rather than folded in quietly.

Third, smaller: a closure character above a hold lane inside one word now
acts. The old `char_first` required the closure to precede the first
other-control lane, which swallowed a `/T/` behind an `/I/` in the same word —
not reading (i). The stimulus is unproducible (REQ-016's wrapper injects whole
idle cycles, so the hold lane is lane 0 and no octet is at stake); where it is
driven anyway, coverage still stops at the hold lane and the frame closes at
the character. Declared, in the source comment and here.

#### 3. WO-0031's R1/R2 do **not** change my obligation — with the derivation

I was asked to conclude or return the question. I conclude, and this is why,
not a guess:

- **R1** repairs a claim about *when two reports coincide*. My design does not
  read that clause: each frame's report cycle is computed from §9's two rules
  directly (the `tlast` cycle where a word is emitted; two cycles after the
  closing word where none is). Whatever wording lands, the arithmetic is the
  same arithmetic.
- **R2** is the one that could have reached me — §9's rule says W + 2, its
  gloss ("the cycle on which that frame's `tlast` word would have been
  emitted") implies W + 3 for a frame whose ending character lies in its own
  start word. I implement **W + 2**, and every committed artefact agrees:
  dv's own M03-R1 table pins B's `error_runt` to W + 2 for a frame opened
  **and** closed in word W; §6.1's consequence 1 says the aborted frame's
  strobe is "one cycle earlier than the new frame's report", and a lane-0
  `/S/` puts that `tlast` at W + 1; WO-0029 §3a's correction uses W + 2
  throughout. R2 aligns the gloss to the rule; it does not move the rule.

If the architect resolves R2 the other way, that is a behavioural change to
this module and I want it as its own packet — the q-channel depth is the only
thing that moves.

#### 4. Expected CI outcome

- `dune build @default`: green. No new library, no new instantiation (still
  M02 and nothing else, REQ-018), one `Reg_spec`, no port added or renamed.
- **Determinism step red**, with **`rtl_snapshots/xgmii_rx_64.v` and
  `rtl_snapshots/eth_mac_10g.v`** as the diff — M03's body changed, and M05
  carries M03 hierarchically. The build.yml promotion block (sha256 + base64)
  is the promotion source; promote verbatim, second run green (REQ-902).
- **`rtl_snapshots/xgmii_tx_64.v` and `rtl_snapshots/word_counter.v` must NOT
  move.** M04's source, M01's and the bootstrap module's are untouched, and
  `Crc32_eth` — emitted as a child inside both changed files — is untouched.
  Movement in either is a determinism defect, not this change, and should be
  treated as one.
- dv mechanical checks: unchanged in kind. REQ-001's resolver sees the same
  single clock alias; REQ-018's whitelist sees the same instantiation set;
  REQ-017's port names are `.mli`-fixed and did not move.

#### 5. Cycle arithmetic: nothing observable moved

No pipeline stage was added or removed on the payload path — `data_d` →
alignment mux → `al_data_d`, and `cov` → `cov_d` → `al_keep` → `al_keep_d`,
exactly as at `f840475`. The two new registers are the q-channel's and sit on
the report path, parallel to the record channel, which is itself off the
payload. `cov_first`, the front offsets and every instance of the m + 3
formula are unchanged.

**dv's rows M03-L2/L3 survive unchanged**: h = 8 with **L = 16** at a lane-0
start, h = 12 with **L = 12** at a lane-4 start, ΔC = 3 at both, (L + h) = 24.
Re-derived by tracing a 64-octet frame at each start lane through the repaired
decode: output word 0 leaves on cycle 3 counted from the start word in both
cases. No pinned constant in SPEC-M03 §7 moved, and none in §8's checks.

#### 6. Returned questions (not resolved here)

1. **§9 row 6 versus the co-occurrence list — does `error_bad_fcs` pulse for
   a frame with fewer than 5 octets?** A zero-octet frame's running CRC is the
   0x00000000 seed, never REQ-304's residue, so the delivered module pulses
   `error_bad_fcs` alongside `error_runt` for a `/T/`-closed zero-delivered
   frame. §9's row 6 says "no FCS removal is attempted on a frame with nothing
   to remove it from" and lists **only** `error_runt`; §9's co-occurrence
   bullet scopes the `error_runt`-with-`error_bad_fcs` pairing to **5–63**
   octets. This behaviour is unchanged from `f840475` and I did not change it
   in either direction — but the ruling makes it load-bearing: REQ-102's hook
   now commissions the `/T/`-in-a-preamble-lane frame, and the M03-N2 ASSERT
   row names **two** strobes, not three. Architect's call; a bench asserting
   "exactly one strobe" fails today.
2. **WO-0032 deliverable 1's example, `/S/` lane 2 + `/T/` lane 5.** A start
   character outside lanes 0 and 4 is §6.3 item 3 (unconstrained) and REQ-101
   names only two start lanes, so this module lets it **close** epoch A and
   **open nothing** — the alignment window has two offsets, not eight. The
   `/T/` at lane 5 then finds no open frame and is ignored (REQ-113). The
   specified instance of "both take effect" is `/S/` in lane 0 or lane 4 with
   a closure above it, and that is implemented. Flagging in case the example
   was meant literally.
3. **Latent, pre-existing, on a stimulus §10 forbids**: `first_v` (the
   new-frame marker feeding the FCS-straddle lookahead) is gated by
   `Preamble`, so a frame whose first-octet word is displaced by an idle word
   injected *inside its own preamble* would carry no marker. §10's REQ-016
   hook forbids the wrapper from injecting there and §6.2 now aborts that
   frame under REQ-105 at a lane-4 start, so there is no reachable case. Noted
   because I found it, not because it needs work.

#### 7. Evidence and its limits (ADR-0005)

No local build exists and none was claimed. What was run: a **syntax-only**
parse (`ocamlc -stop-after parsing`, 4.14.1) on a scratch copy — exit 0. That
is a parse, not an elaboration and not verification; the elaboration evidence
is CI's, and the byte-identity evidence REQ-902 needs rides the promoting
commit's second run. Correctness argument is by line-by-line self-review
against SPEC-M03 at `541ea43`, with hand traces of: the 64-octet frame at both
start lanes; dv's M03-R1 minimal witness (four delivered octets,
`error_start_without_terminate` at W + 2 and `error_runt` at W + 2, different
names); REQ-110's `/S/`-lane-4-of-an-`/S/`-word (exactly one pulse, second
frame intact); REQ-102's `/T/`-, `/E/`- and `/I/`-in-a-preamble-lane frames at
both start lanes; REQ-108's 1518-legal versus 1519-oversize boundary and its
`/S/` resynchronisation; and the record-ageing invariant under
consecutive-cycle closures, which the old comment's justification ("two
closures are never less than two cycles apart") no longer supports and which
now rests on §6.1's m + 3 instead.

### ACCEPTED — orchestrator, 2026-08-03T07:20Z, journal `J-orchestrator-0077`

Run 30758091238 (head `15e2458`) full green: determinism re-proves
REQ-902 over the conformant three-epoch M03; dv's X-9 passes over the
new text in CI as it did locally; quantifier green. Run chain:
30757589286 (designed red, Build+tests green — third first-try blind
elaboration) → 30758091238 (green). Promotion was two files exactly;
the two still-files rtl_lead named stayed still. The two returned
questions (§9 row 6 sub-5-octet `error_bad_fcs`, now load-bearing at
REQ-102's newly commissioned frame; the /S/-lane-2 example) queue for
the next architect-bound packet. R2-resolves-to-W+3 contingency noted:
behavioural, own packet if it ever fires.
