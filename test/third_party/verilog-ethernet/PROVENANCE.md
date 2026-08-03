# PROVENANCE — vendored reference from `alexforencich/verilog-ethernet`

This directory vendors, byte-verbatim, exactly the module under differential
comparison (`axis_xgmii_rx_64`) and its instance closure (`lfsr`), plus
upstream's licence file, per `docs/adr/ADR-0015-the-cosim-lane-dependency-reference-and-determinism.md`
§D2. It is the reference side of the co-simulation lane opened by `WO-0044`,
against our `Xgmii_rx_64` (M03).

## Upstream

- **Repository**: https://github.com/alexforencich/verilog-ethernet
- **Pinned commit SHA (40-hex)**: `77320a9471d19c7dd383914bc049e02d9f4f1ffb`
  — resolved via `git ls-remote https://github.com/alexforencich/verilog-ethernet.git master`
  (the GitHub REST API — `api.github.com/repos/.../commits/master` — is not
  reachable from this session/environment; `git ls-remote` over the git
  smart-HTTP protocol is, and resolves the same ref). Cross-checked against
  `git ls-remote .../HEAD`, which returned the identical SHA, confirming
  `master` is upstream's default branch.
- **Fetch date**: 2026-08-03
- **Fetch method**: `raw.githubusercontent.com/alexforencich/verilog-ethernet/<SHA>/<path>`,
  one file per request, each returning HTTP 200. (`/archive/` and `codeload`
  tarball endpoints are known 403-blocked from this environment per
  ADR-0005's measurement, reconfirmed by ADR-0015 D2; raw file fetches are
  not affected and are the fetch path used here.)

## Files, per-file upstream path and sha256 as vendored

| File in this directory | Upstream path | Bytes | sha256 |
|---|---|---|---|
| `axis_xgmii_rx_64.v` | `rtl/axis_xgmii_rx_64.v` | 13,496 | `99d2b9578a440f03232030ae3da72eeb26b1cc8321d8eb24aa34b98fc46b8ccb` |
| `lfsr.v` | `rtl/lfsr.v` | 16,327 | `5502c8203b0dfc7246c1a2de93e60c199ded3c1d7840b106350d714f72a9a079` |
| `COPYING` | `COPYING` | 1,062 | `8ea57f95365e9b16a5b516f422b71269183a1ae53bab5878ae6d69039e58fe77` |

All three sizes match the ADR-0015 D2 measurement exactly (13,496 / 16,327 /
1,062 bytes), taken on the same date via the same raw-fetch path but without
a recorded pinning SHA; this vendoring re-derives the sha256 and the closure
check independently, at an explicitly named 40-hex commit, per this task's
instruction that the ADR's own closure measurement was against an unpinned
`master` and must be re-derived at the pin.

## Closure re-derivation, at this pin (not asserted from the ADR — re-checked)

- `axis_xgmii_rx_64.v` — 449 lines, 13,496 bytes. Instantiates **exactly one**
  module: `lfsr` at line 177 (`lfsr #( ... ) eth_crc ( ... )`, instance name
  `eth_crc`, the CRC-32). No other instantiation-shaped construct appears
  anywhere else in the file (checked by pattern search across the whole
  file, not just the neighbourhood of line 177). No `` `include `` directive
  anywhere in the file.
- `lfsr.v` — 447 lines, 16,327 bytes. Instantiates nothing; it is a leaf
  module. No `` `include `` directive.
- **Result: closure confirmed at the pin.** The two files above are the
  complete simulatable closure for `axis_xgmii_rx_64`; no third file is
  needed and none is vendored.

## Verbatim rule — never edit these files

`axis_xgmii_rx_64.v`, `lfsr.v` and `COPYING` are copied **byte-for-byte** from
upstream, headers included, and **must never be edited in place** — not for
whitespace, not for tidying, not for anything. Per ADR-0015 D2:

- Each source file carries its own MIT notice in its header with its own
  copyright years, and those years are part of the attribution the original
  author wrote. Editing a header — even whitespace-only — narrows that
  attribution, which is why the no-edit rule is a **licensing rule**, not
  merely a provenance preference.
- REQ-901's configuration requirements (deficit idle count disabled, padding
  enabled, minimum frame length 64, PTP disabled, transmit checksum
  generation disabled) are all **module parameters** on
  `axis_xgmii_rx_64 #(DATA_WIDTH, KEEP_WIDTH, CTRL_WIDTH, PTP_TS_ENABLE,
  PTP_TS_FMT_TOD, PTP_TS_WIDTH, USER_WIDTH)` and are set at **instantiation**,
  in the harness's own wrapper file (not vendored here) — configuration is a
  parameter passed in, never a patch applied to this file.
- If a change to the reference genuinely became necessary, it lands as a
  separate patch file applied at build time, never as an in-place edit to
  the files in this directory. A modified vendored file whose header still
  claims an unmodified upstream SHA would be a false provenance record.
- **Pin bumps are their own commit.** Changing the pinned SHA above changes
  what the anchor is; a bump lands as its own commit, with this file's diff
  showing old SHA → new SHA and the re-run comparison result, never folded
  into a harness change.

## Licensing — three notices, not one (why all three ship)

Upstream is MIT-licensed, but the copyright line is **not** the same in all
three places, which is exactly why all three notices are vendored rather
than just one being treated as authoritative:

- `COPYING` (upstream's root licence file, copied verbatim under its own
  upstream name — not renamed to `LICENSE`): **`Copyright (c) 2014-2018 Alex
  Forencich`**.
- `axis_xgmii_rx_64.v`'s header notice: **`Copyright (c) 2015-2017 Alex
  Forencich`**.
- `lfsr.v`'s header notice: **`Copyright (c) 2016-2023 Alex Forencich`**.

None of these three copyright-year ranges matches either of the other two.
Per ADR-0015 D2, the per-file header notices are **not redundant** with
`COPYING` — they carry different copyright years than `COPYING` and than each
other — so stripping either source file's header on the theory that
`COPYING` already "covers" licensing would silently narrow the attribution to
a range the file's own author did not write. All three notices (the two
headers plus the root `COPYING`) are therefore vendored and preserved
byte-verbatim, and none may be edited or removed.

## Independence boundary (PROTOCOL §10 / ADR-0015 D2 ruling)

This vendored reference is **outside the `libs/**` read bar**: it is a
third-party implementation, not the design under test, so DV agents
(dv_lead, tb_writer, formal_dv) may read it. The converse obligation is
load-bearing and stated here for anyone reading this file in isolation:
**no attack-plan row's expected value and no golden-model outcome may be
changed to match this reference.** A co-simulation divergence resolves only
as (a) a defect against our RTL, (b) a documented-divergence entry citing the
SPEC-M03 clause or reference behaviour that explains it, or (c) a spec diff
with its own ADR — never by amending an expectation to agree. `libs/**` and
`rtl_snapshots/**` remain barred to DV agents, unchanged by this vendoring.
