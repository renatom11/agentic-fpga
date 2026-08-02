# WO-0033: The verification machinery — X-1 … X-11
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your own machinery-gap register (J-dv_lead-0013,
  WO-0027 deliverable 4 — the X-1…X-11 list is yours verbatim); the
  two attack plans those gaps block (136 rows, now 0 RULING after
  e22e3f0); your charter's external-anchor precondition for golden
  models; C-23 (strobe high-cycle counting), C-45 (idle-injection
  lane-0 scope — your own wording), the WO-0031 injection scope note
  (REQ-016 injection moves the two lane-0-/S/ rows earlier, never
  onto the other report); the WO-0012 latency-tagger precedent.
- **Deliverables**:
  1. The eleven, under test/** (oracles in test/golden/), each
     derived from spec text alone — libs/** stays unread:
     X-1 link-partner error-injection catalogue (per-frame expected
     §9 outcomes); X-2 XGMII probe; X-3 strobe monitor (C-23
     counting, §9 pinned-cycle check, §0.6 window); X-4
     idle-injection wrapper carrying the M03-N3 constraint AS
     REPAIRED at 06c1eba and C-45's lane-0 scope; X-5/X-9 the
     per-frame output-extent repair on the latency tagger (one
     repair, two customers: M03 aborts, M14 padding); X-6 Axi64
     stream driver (from SPEC-M01's compile-checked records); X-7
     M08-output stimulus model composed from X-1's model; X-8 IPv4
     header builder + one's-complement checksum oracle, EXTERNALLY
     ANCHORED per your charter (name the authority and its vectors
     in the file); X-10 the OCaml D oracle beside
     tools/check_abort_availability.sh; X-11 M14's seven strobe
     cycles.
  2. dune-integrated: `dune runtest` exercises what can be exercised
     without RTL (oracle self-checks, model-vs-catalogue expect
     tests); state the expected CI outcome in your Return log
     (Build green is load-bearing — this is your largest OCaml
     sitting; ADR-0005 blind-writing discipline applies).
  3. Staging is yours: if one sitting risks the output cap, build
     the M03-critical core first (X-1…X-6, X-9) and RETURN with the
     remainder explicitly deferred and reasoned — a stated partition
     is a good return; a silent one is not. Incremental writes
     (≤~300 lines per tool call, one file complete before the
     next).
  - Journal **J-dv_lead-0017**; Files-in-this-commit exact.
- **Out of scope**: benches themselves (tb_writer WOs follow, on
  this machinery); libs/** (reading included); docs/** (spec gaps
  return as questions); tools/** except reading X-10's neighbour;
  committing. rtl_lead's two WO-0032 questions (§9 row 6 sub-5-octet
  `error_bad_fcs`; the /S/-lane-2 example) are architect-bound and
  deliberately NOT in this WO.
## Task
Everything the 136 rows need and do not have. You named these gaps;
now close them.
## Return / verdict log
