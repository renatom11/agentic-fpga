# ADR-0005: CI is the authoritative build environment

- **Status**: Accepted
- **Deciders**: orchestrator (environment constraint, no scope or cost impact)
- **Date**: 2026-08-01 (M1)

## Context

M1 attempted to install the ADR-0004 toolchain (released Hardcaml v0.17.x)
inside the development container. It cannot be done. The container's network
policy permits git operations and GitHub *release-asset* downloads, but denies
the paths opam needs for compilers and Jane Street packages:

| Endpoint | Result |
|---|---|
| `opam.ocaml.org/index.tar.gz` | unreachable (proxy CONNECT refused) |
| `github.com/<org>/<repo>/archive/…` | HTTP 403 |
| `codeload.github.com/…` | HTTP 403 |
| `github.com/ocaml/dune/releases/download/…` | **200 — works** |
| `raw.githubusercontent.com/…` | **200 — works** |
| `git clone https://github.com/…` | **works** |

Consequences of that split, established empirically rather than assumed:

- `opam init` against the git-backed opam-repository succeeds; `dune`
  installs (its source is a release asset).
- The OCaml **compiler** cannot be installed: every 5.x source URL tried
  (`github /archive/`, `caml.inria.fr`, `ocaml.org`) is blocked or absent.
  The system compiler is 4.14.1.
- Hardcaml v0.17's `hardcaml_waveterm` requires OCaml ≥ 5.1, and Hardcaml
  master requires ≥ 5.3, so **no Hardcaml line is installable on 4.14.1**.
- Jane Street packages fetch from `/archive/` URLs, which are 403 regardless.

## Decision

**GitHub Actions CI is the authoritative build and test environment.** OCaml
correctness — compilation, expect tests, RTL emission, determinism — is
established by the `build` workflow, not by any local run. A local switch is
a convenience, not a dependency, and no gate signature may rest on a local
build result.

Practical rules this implies:

1. Every OCaml work order's Evidence cites a **CI run ID and conclusion**
   (permitted form (b) under the ADR-0003/F5 Evidence rule), not a local
   command whose environment cannot reproduce it.
2. Expect-test snapshots are **promoted from CI's own diff output**, never
   authored by hand. Writing a plausible-looking waveform into an expect
   block would be fabricated evidence — the one thing the journal protocol
   exists to prevent.
3. The protocol/enforcement suite (`scripts/test_protocol.sh`, bash only)
   remains locally runnable and stays the local gate for process work.
4. Agents writing Hardcaml must expect a CI round-trip per verification
   cycle, and should batch work accordingly rather than pushing per edit.

## Alternatives considered

- **Vendor the Hardcaml sources into the repo** (the sponsor offered to
  supply them): rejected — the blocker is the *compiler* plus ~40 transitive
  Jane Street packages, not the Hardcaml source alone, so this does not
  produce a working switch and would pollute the repo with third-party code
  the licensing rules keep out.
- **Downgrade to a Hardcaml line supporting OCaml 4.14**: no released line
  qualifies (v0.17 waveterm already requires 5.1), and pinning older
  Hardcaml would contradict ADR-0004 for a convenience, not a capability.
- **Loosen the environment's network policy**: outside the org's control —
  it is a property of the sponsor's Claude Code environment configuration.
  If the sponsor ever widens it, a local switch becomes possible and this
  ADR should be revisited; the decision above remains correct regardless,
  since CI stays the environment gate signatures cite.

## Consequences

- Slower OCaml iteration (minutes per CI round trip) — accepted; it does not
  affect correctness, only cadence, and M1's spec work is unaffected.
- CI becomes load-bearing for the program, so the `build` workflow is itself
  an artifact worth auditing (it is committed, versioned, and in scope for
  process audits like any other).
- The constraint is stated in the workflow header and here, so a future agent
  hitting `opam install` failures reads the reason instead of re-deriving it.
