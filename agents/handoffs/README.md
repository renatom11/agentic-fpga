# Handoff Packets

All inter-agent transfers are versioned files in this directory, never
chat-only (`agents/PROTOCOL.md` §3). Naming: `WO-NNNN_<slug>.md`,
`SO-<module>.md`, `BUG-NNNN_<slug>.md`, `RV-NNNN_<slug>.md`. Numbers are
zero-padded and monotonic per prefix; the **orchestrator allocates** the next
number when a packet is first committed (drafts use a placeholder id), making
the sole committer the sole numbering authority (PROTOCOL §3).

## Work order (`WO-`) — lead/orchestrator → worker or lead

```markdown
# WO-NNNN: <title>
- **State**: DRAFT | ISSUED | RETURNED | ACCEPTED | BOUNCED
- **From** / **To**: <agent> → <agent>
- **Spec basis**: <docs/specs/... sections; REQ-### ids>
- **Deliverables**: <files to produce, inside assignee's write scope>
- **Definition of done**: spec section satisfied | required tests | journal
  entry appended | docs touched or "no doc impact"
- **Context provided**: <exact files/excerpts handed to the assignee —
  tb_writer WOs deliberately omit RTL source>
- **Out of scope**: <explicit exclusions>
## Task
<the ask>
## Return / verdict log
<appended on RETURNED/ACCEPTED/BOUNCED, with journal-entry refs>
```

## DV sign-off packet (`SO-`) — dv_lead → orchestrator (VERBATIM relay; merge precondition)

```markdown
# SO-<module>: PASS | FAIL
- **Module / spec**: <libs path, spec section, REQ-### covered>
- **Suite**: <test names, how to run — exact commands>
- **Coverage vs spec**: <requirement → test mapping; gaps declared>
- **Line-rate stress**: <back-to-back min-frame result, rx-path modules>
## Seeded-defect dispositions
- **Sealed**: <every class the manifest sealed, nothing removed for any reason>
- **Seeded**: <the subset rendered against the module as sealed, and run — the
  gate clause reads this number, not the one above>
- **The difference, itemized**: <each class in sealed-and-not-seeded, by name,
  with its ground: never rendered | unscoreable | negative control | <other>>
  <!-- All grounds sit in `sealed`, none in `seeded`, each named here with its
       ground. A negative control is rendered and run and still does not enter
       `seeded`. Drop this line and the two definitions above contradict each
       other. -->
- **Per seeded class**: <one row each — killed, with the killing unit or units
  named and present-and-green at the gate SHA; or not killed, with its
  disposition in the evidence form PROTOCOL §7 (b.2) requires. No non-kill is
  folded into a kill.>
- **Unreachable set**: <published beside the dispositions, never inside them>
- **Open defects**: <BUG refs or none>
- **Signed**: J-dv_lead-NNNN
```

> **Why this block is five fields and not one number.** `PROTOCOL` §7 (b.1)–(b.4)
> forbids the ratio in terms — *no ratio stands in for the dispositions*, *no
> `N/N` figure is read as coverage* — and this skeleton demanded
> `Mutation kills: N/N` until **2026-08-22**, so an adopter copying the form
> committed, on first use, the thing the constitution beside it prohibits
> (`ADR-0024` §13.1; `docs/PROCESS-MEMOIR.md` Annex B.2 item 14). The one
> sign-off in this record refused the ratio and reported columns instead; the
> form now says what that seat did. A filled instance with real figures and its
> closure arithmetic is at `docs/PROCESS.md` §3.9.

## Bug packet (`BUG-`) — dv_lead → rtl_lead (VERBATIM relay)

```markdown
# BUG-NNNN: <title>
- **Module / severity**: <path> | CRITICAL/MAJOR/MINOR
- **Reproduction**: <exact command at SHA>
- **Observed vs expected**: <spec clause cited>
- **Fix verdict**: (appended by dv_lead after re-test; fix entries must
  contain a Root-cause section before the fix description)
```

## Review verdict (`RV-`) — reviewing lead → worker (summarizable relay)

```markdown
# RV-NNNN: ACCEPT | BOUNCE (re: WO-NNNN)
- **Defects**: <numbered list, file:line, spec clause violated — or none>
- **Signed**: J-<agent>-NNNN
```
