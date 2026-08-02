# `tools/precompile_stubs/` — transcriptions, not implementations

Every file in this directory is a **transcription of a signature that lives
somewhere else**. None of them is an implementation: every value body is a
`failwith`, because nothing here is ever linked or run. They exist so that
`tools/precompile_check.sh` lane 2 can type-check the DV files that name
Hardcaml types, in an environment where ADR-0005 blocks the Hardcaml
toolchain but not the system `ocamlc`.

Each file's header states, in this order:

1. **SOURCE** — the exact path (and version) the signature was transcribed
   from.
2. **VERIFIED / UNVERIFIED** — whether `precompile_check.sh` lane 2b can
   mechanically re-check the transcription against that source at run time,
   and what happens when it cannot.
3. **SCOPE** — which names are transcribed. A stub is deliberately *minimal*:
   it carries only the names the DV tree uses, so an addition to the DV tree
   that needs a new name fails lane 2 loudly instead of being silently
   approximated.

## What a green lane 2 does and does not prove

It proves **my own scoping, labels, arities and record-field spellings** in
the Hardcaml-facing DV files. That is the defect class that produced the
programme's first Build escape (`J-dv_lead-0018`, `injection.ml:380`).

It does **not** prove that the transcription matches the real library —
except exactly where lane 2b says it re-checked it. A stub that has drifted
from its source produces a green lane 2 and a red CI build, which is why
lane 2b exists and why every file below names its source path rather than
describing it.

**CI, not this harness, is authoritative** for the real API (ADR-0005).
`precompile_check.sh` stands down automatically when the real toolchain is
present.
