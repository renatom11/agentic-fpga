# WO-0037: The anchor check's first catch — and the first bench packet
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: run 30764198256's verdict from your own
  tools/check_rfc1071_anchor.sh — the runner's egress is OPEN, RFC
  1071 was fetched (53,524 bytes, sha256 e10dfd68…), §3 sliced (64
  lines), and the verdict is NOT CONFIRMED exit 1: sum 0xddf2 found
  as a delimited token, octet pairs '00 01' 'f2 03' 'f4 f5' 'f6 f7'
  NOT found, checksum 0x220d NOT found, negative control clean. The
  check's own text: "Either the oracle's constants are wrong or this
  script's extraction is. Both are defects and both belong in a
  packet." This is that packet.
- **Deliverables**:
  1. Judge which defect it is, from the fetched text (the runner
     printed provenance + sha256; re-fetch from CI if you need the
     §3 lines — or state precisely what evidence you need from me).
     Plausible shapes you'll want to rule between: the RFC formats
     the example differently than your delimited-pair extraction
     expects; or §3 states the sum but never prints the final
     checksum (making the oracle's "§3 prints" claim an overclaim on
     a correct constant); or the constants are genuinely wrong.
  2. Repair whichever side is defective — test/golden/ipv4_ref.ml's
     provenance claims and/or tools/check_rfc1071_anchor.sh's
     extraction — keeping the check's fail-loud semantics and its
     self-test honest. The local arithmetic lane already proves the
     constants CONSISTENT; what's at stake is the QUOTED claim.
     Expected CI after your fix: dv_checks green end to end, which
     also closes the SO- anchor obligation with a run id.
  3. THEN, the program's next frontier: author the first tb_writer
     work-order packet — the M03 core rows on your machinery
     (your call which rows constitute the right first bench slice;
     the plan is at 74 rows, 58 ASSERT). Write it as
     agents/handoffs/WO-0038_tb-m03-first-bench.md DRAFT (state
     DRAFT, I flip to ISSUED when I spawn the worker): scope,
     deliverables, the machinery contracts the bench must use, what
     the worker may not read (libs/** stays out per your charter's
     bench-independence rule), and the PASS/FAIL packet format you
     expect back.
  - Journal **J-dv_lead-0021**; Files-in-this-commit exact.
- **Out of scope**: libs/**, docs/**, bin/**, build.yml; committing.
## Task
Your check worked on its first real chance — now close what it
caught, and open the bench campaign.
## Return / verdict log
