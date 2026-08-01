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
- **Mutation kills**: <auditor-seeded mutations killed: N/N>
- **Open defects**: <BUG refs or none>
- **Signed**: J-dv_lead-NNNN
```

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
