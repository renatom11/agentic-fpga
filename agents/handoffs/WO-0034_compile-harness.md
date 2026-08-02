# WO-0034: The real-compile harness into tools/ — and the RFC anchor closed from CI
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your own J-dv_lead-0018 Open-questions ask (the
  three-lane harness "would be worth more committed under tools/
  where the auditor could re-execute it"); your J-dv_lead-0017
  Evidence item 7 + the WO-0033 acceptance block (RFC 1071 anchor
  open after five 403s across two egress paths; your named cheapest
  closure: one CI step); ADR-0005 (which blocks the Hardcaml
  toolchain, not the system compiler — your own discovery).
- **Deliverables**:
  1. tools/precompile_check.sh — the three-lane harness from the
     J-dv_lead-0018 addendum, reconstructed as a committed, auditor-
     re-executable script: lane 1 real-compiles the Hardcaml-free
     test libraries with the system ocamlc; lane 2 compiles
     Hardcaml-facing files against stubs transcribed from the real
     signatures (stubs committed beside it, marked as transcriptions
     with their source paths); lane 3 the cross-library
     qualification sweep. Self-documenting output; nonzero exit on
     any lane failure.
  2. Wire it into tools/dv_checks.sh (or its own CI step via a
     Return-log request to me if you judge the workflow file the
     better seam — build.yml is mine, tools/ is yours).
  3. A CI-side RFC 1071 anchor check: a step or script that fetches
     RFC 1071's text FROM THE RUNNER (its egress is open), extracts
     §3's example and the two §2 properties, and compares against
     `Ipv4_ref.rfc1071_example_{octets,sum,checksum}` — turning the
     open SO- obligation into a mechanically re-verified fact. If
     the fetch fails on the runner too, the obligation stays open
     and the step must say so loudly, not pass vacuously.
  4. Note for your Return log: whether rtl_lead can use lane 2's
     stub approach against hardcaml's real signatures (the sources
     are readable at the opam switch) — a question, not a build.
  - Journal **J-dv_lead-0019**; Files-in-this-commit exact.
- **Out of scope**: libs/**, docs/**, bin/**; build.yml (request,
  don't edit); committing.
## Task
Your harness caught nothing less than the org's first Build escape's
entire class. Commit it where the auditor can run it, and close the
one obligation your evidence left open.
## Return / verdict log
