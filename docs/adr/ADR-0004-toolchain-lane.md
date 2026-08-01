# ADR-0004: Toolchain lane — released Hardcaml v0.17.x from opam

- **Status**: Accepted (sponsor decision, E3, 2026-08-01)
- **Deciders**: Renato (sponsor), on orchestrator escalation with options +
  recommendation + cost (PROTOCOL §8)

## Context

Every M1+ artifact — dune project, CI, specs' compile-checked Interface
records, all RTL and tests — binds to one of three Hardcaml lanes: the
opam-released v0.17.x line, pinned master-branch SHAs (the ZPrize approach),
or Jane Street's OxCaml branches.

## Decision

**Released v0.17.x from opam.** Reproducible one-command installs, docs that
match the code, standard OCaml, lowest CI risk. Exact versions are locked in
the project's opam files; the toolchain the specs compile against is pinned
from this ADR forward.

## Alternatives

- **Master pins**: newest APIs, but source builds in CI, re-pin breakage
  surface, docs lag. Rejected as premature — nothing in Phase 1–2 scope is
  known to need post-v0.17 APIs.
- **OxCaml branches**: nonstandard compiler, highest friction, no scope
  justification. Rejected.

## Consequences

- M1 proceeds: dune/opam skeleton, OCaml CI alongside journal-check, and the
  architect's compile-checked spec records all target v0.17.x.
- If a needed API is missing from the release line, that is a **new E3** —
  raised at or before P1-spec-freeze with the specific gap named, not a quiet
  re-pin.
