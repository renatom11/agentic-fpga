#!/usr/bin/env python3
"""Build the showcase site from repo state — one command, everything fresh.

Generates index.html and backlog.html, and idempotently applies "site
chrome" (shared head metadata, nav pills, the org-chart journal strip) to
the three artifact pages. Rerun after the program moves; every number and
the work-order ledger come from the same files the agents work from.

Copy shaped by a four-agent review panel (three auditors + the sponsor's
representative) on 2026-08-02; the representative's rulings are the spec
for this page's voice. Regenerate: python3 site/build.py
"""
import html, os, re, subprocess, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from framework_figs import FRAMEWORK_CSS, FIGS

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PUB = os.path.join(ROOT, 'site', 'public')

# Set to the deployed origin (e.g. "https://agentic-fpga.example.workers.dev")
# to emit absolute og:image URLs; empty emits root-relative (fine for the
# page, weaker for link-preview crawlers).
SITE_URL = os.environ.get('SITE_URL', '')
# The repository is private during Phase 1: no external source links.
REPO_PUBLIC = False
REPO_URL = 'https://github.com/renatom11/agentic-fpga'

def sh(*args):
    return subprocess.run(args, cwd=ROOT, capture_output=True, text=True).stdout

# ---- live numbers -----------------------------------------------------------
n_commits = int(sh('git', 'rev-list', '--count', 'HEAD'))
AGENTS = [
    ('orchestrator', 'orchestrator'),
    ('dv_lead', 'verification lead'),
    ('architect_docs_lead', 'architect'),
    ('rtl_lead', 'hardware designer'),
    ('auditor', 'auditor'),
]
jcounts = {}
jdir = os.path.join(ROOT, 'agents', 'journals')
for a, _ in AGENTS:
    # A journal is a volume chain (ADR-0017): claude_X_agent.md is volume 01,
    # rotations append .v02, .v03, … — count entries across every volume, or
    # the figure freezes at each rotation (the v01-only bug this replaces).
    vols = [f for f in os.listdir(jdir)
            if re.fullmatch(rf'claude_{a}_agent(\.v\d+)?\.md', f)]
    jcounts[a] = sum(
        len(re.findall(r'^## \[J-', open(os.path.join(jdir, v)).read(), re.M))
        for v in vols)
n_entries = sum(jcounts.values())
head_sha = sh('git', 'rev-parse', '--short', 'HEAD').strip()
gen_date = sh('git', 'log', '-1', '--format=%ad', '--date=format:%Y-%m-%d').strip()

board = open(os.path.join(ROOT, 'tasks', 'BOARD.md')).read()
# A row's State cell is free text ("CLOSED · 8/8", "ACCEPTED · CI GREEN") —
# the original single-word pattern silently dropped every row after WO-0038,
# and the build line's "38 WOs" was that bug announcing itself unread. The id
# may be a link or bare text (some rows have no packet file).
wo_rows = re.findall(
    r'^\| \[?(WO-\d{4})(?:[^|]*?)? \| ([^|]*) \| ([^|]+?) \| (.*?) \|$', board, re.M)
wo_rows = [(wid, fromto.strip(), state.strip(), note) for wid, fromto, state, note in wo_rows]
wo_rows.sort(key=lambda r: int(r[0][3:]), reverse=True)  # T6/D5: newest id first

n_attack = 0
plans = set()
assert_ids = {}   # base -> set of row ids the plan marks ASSERT
for ap in os.listdir(os.path.join(ROOT, 'test', 'attack_plans')):
    if ap.startswith('AP-') and ap.endswith('.md'):
        base = ap[3:-3]
        plans.add(base)
        aptxt = open(os.path.join(ROOT, 'test', 'attack_plans', ap)).read()
        n_attack += len(re.findall(r'^\| \*\*M\d{2}-[A-Z]\d+\*\*', aptxt, re.M))
        assert_ids[base] = set(
            m.group(1) for m in re.finditer(
                r'^\| \*\*(M\d{2}-[A-Z]+\d+)\*\*.*\| ASSERT \|$', aptxt, re.M))

# ---- module matrix, derived from the trees (H1) -----------------------------
MODULES = [
    ('M01', 'Axi64', 'axi64'), ('M02', 'Crc32_eth', 'crc32_eth'),
    ('M03', 'Xgmii_rx_64', 'xgmii_rx_64'), ('M04', 'Xgmii_tx_64', 'xgmii_tx_64'),
    ('M05', 'Eth_mac_10g', 'eth_mac_10g'), ('M06', 'Eth_axis_rx', 'eth_axis_rx'),
    ('M07', 'Eth_axis_tx', 'eth_axis_tx'), ('M08', 'Eth_demux', 'eth_demux'),
    ('M09', 'Eth_arb_mux', 'eth_arb_mux'), ('M10', 'Arp_eth_rx', 'arp_eth_rx'),
    ('M11', 'Arp_eth_tx', 'arp_eth_tx'), ('M12', 'Arp_cache', 'arp_cache'),
    ('M13', 'Arp', 'arp'), ('M14', 'Ip_eth_rx_64', 'ip_eth_rx_64'),
    ('M15', 'Ip_eth_tx_64', 'ip_eth_tx_64'), ('M16', 'Ip_complete_64', 'ip_complete_64'),
    ('M17', 'Udp_ip_rx_64', 'udp_ip_rx_64'), ('M18', 'Udp_ip_tx_64', 'udp_ip_tx_64'),
    ('M19', 'Udp_complete_64', 'udp_complete_64'), ('M20', 'Nic_top', 'nic_top'),
]
MODS = []
for mid, name, base in MODULES:
    specp = os.path.join(ROOT, 'docs', 'specs', 'modules', f'{base}.md')
    spec = os.path.exists(specp) and bool(
        re.search(r'\*\*Status\*\*: \*\*FROZEN\*\*', open(specp).read()))
    rtl = os.path.exists(os.path.join(ROOT, 'libs', 'hardcaml_ethernet', 'src', f'{base}.ml'))
    plan = base in plans
    # A module has benches when a test directory of its name holds test files.
    benchdir = os.path.join(ROOT, 'test', base)
    bench = os.path.isdir(benchdir) and any(
        f.startswith('test_') and f.endswith('.ml') for f in os.listdir(benchdir))
    # Verified = attack-plan ASSERT rows discharged by the bench: named in an
    # expect-test title, or discharged by citation. Same derivation dv_lead's
    # count uses; a signed SO- packet flips the cell to a check.
    ver = None
    if plan and bench:
        named = set()
        for f in os.listdir(benchdir):
            if f.startswith('test_') and f.endswith('.ml'):
                t = open(os.path.join(benchdir, f)).read()
                for m in re.finditer(r'let%expect_test', t):
                    named |= set(re.findall(r'(M\d{2}-[A-Z]+\d+)', t[m.end():m.end()+300]))
                for line in t.splitlines():
                    if 'discharged by citation' in line:
                        named |= set(re.findall(r'(M\d{2}-[A-Z]+\d+)', line))
        aset = assert_ids.get(base, set())
        signed = any(f.startswith('SO-') and base in f
                     for f in os.listdir(os.path.join(ROOT, 'agents', 'handoffs')))
        ver = (len(named & aset), len(aset), signed)
    MODS.append((mid, name, spec, rtl, plan, bench, ver))
n_rtl = sum(1 for m in MODS if m[3])
n_spec = sum(1 for m in MODS if m[2])
assert n_spec == 20, n_spec

PHASES = [
    ('Build the agent organization', 'done', 'Before any engineering: an org of AI agents with written charters, an append-only work journal per agent, and one-agent-per-commit rules enforced by scripts rather than promises. The rules themselves went through adversarial review before anything ran under them.'),
    ('Prove the org governance works', 'done', 'The independent auditor ran the full loop once on real commits — findings filed, dispositions argued back, adversarially re-checked, first gate countersigned — before the org was trusted with hardware work.'),
    ('Create the specification for the Network Interface Card', 'done', 'The 10G Ethernet subsystem written down before it was built: 110 numbered requirements and 20 frozen module contracts, hardened by the verification lead’s 108-row testability review and signed by the sponsor 2026-08-02. Spec batches were refused more than once before signing — the refusals are part of the record.'),
    ('Build and verify', 'now', f'{n_rtl} of 20 modules exist as hardware code; {n_attack} planned test rows describe exactly how each module will be exercised and what must hold; the verification machinery that runs them is live. Happening now: the benches that execute those tests module by module, then per-module sign-offs where seeded defects must be caught to count.'),
    ('Feed in real market data and test in simulation', 'next', 'Everything runs in simulation — the whole program is simulation-first by design, no physical board required. The card learns NASDAQ’s language: a MoldUDP64 + ITCH 5.0 message parser and a single-symbol order book, then a recorded real trading day is replayed into it packet-for-packet, with wire-to-book latency histograms as the scorecard.'),
    ('Add the fiber-encoding layer (stretch)', 'later', 'The last translation layer between the card’s logic and the light pulses on a real fiber-optic cable (the 64b/66b encoder, in hardware terms). Building it means every layer a physical deployment would need exists in the design — still in simulation — and it closes with a wire-to-wire latency report for the whole card.'),
]

# D4: plain-first, insider reference in parentheses — the standing style.
NEXT = [
    'Seeded-defect campaign against the transmitter’s benches — now commissionable: the abort path finally has killing units, and planted bugs must be caught before any sign-off credit (AP-M04 → SO-M04)',
    'Enforcement hardening implementation plus the governance CI job the councils graduated: each check lands on the surface it actually runs on, and the document’s self-checks become a script instead of a promise (ADR-0021, drift check)',
    'The auditor’s full claim census against the seventh edition — the revision cycle has stopped, so the measurement the last three councils flagged as stale finally re-runs (posture re-measurement 2)',
    'The amendment batch: the constitution absorbs the rule ids its scripts already refuse by, the charters re-quote current law, and the split’s governing decision record collects its three signatures (ADR-0022)',
    'Stage-two packet revision (eleven routed items) and the transmitter’s remaining test families, then independent design review of both newest modules and the cross-simulation lane (M06/M07, co-sim BAR T1)',
    'Accumulate per-module rows on the module-readiness gate toward the sponsor’s signature — the receiver’s fourteen-of-fourteen PASS is row one (P1-module-ready); the first lessons harvest awaits the maintainer’s review (federation inbox PR #3)',
]

# ---- shared style -----------------------------------------------------------
bd = open(os.path.join(PUB, 'block-diagram.html')).read()
fonts = re.findall(r"@font-face \{ font-family: '[^']+'; font-weight: \d+; src: url\(data:font/woff2;base64,[^)]+\) format\('woff2'\); \}", bd)
assert len(fonts) == 3, len(fonts)
FONTS = '\n'.join(fonts)

FAVICON = ('data:image/svg+xml,' +
           '%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 32 32%22%3E'
           '%3Crect width=%2232%22 height=%2232%22 rx=%226%22 fill=%22%23161a19%22/%3E'
           '%3Crect x=%224%22 y=%2211%22 width=%223%22 height=%2210%22 fill=%22%2396a19d%22/%3E'
           '%3Crect x=%228%22 y=%2211%22 width=%226%22 height=%2210%22 fill=%22%2334c3b5%22 opacity=%22.45%22/%3E'
           '%3Crect x=%2215%22 y=%2211%22 width=%228%22 height=%2210%22 fill=%22%2334c3b5%22/%3E'
           '%3Crect x=%2224%22 y=%2211%22 width=%222%22 height=%2210%22 fill=%22%23e0a050%22/%3E%3C/svg%3E')

DESCRIPTION = ('A 10-gigabit Ethernet network card that in simulation parses '
               'a stock exchange\'s data feed and tracks the order book in '
               'hardware, written in Hardcaml by a hierarchy of AI agents under '
               'a human sponsor. Everything tracked in GitHub, with each commit '
               'carrying its author\'s work history and full reasoning.')

def head_block(title, og_title):
    og_img = (SITE_URL.rstrip('/') + '/og.png') if SITE_URL else '/og.png'
    return f'''<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>{html.escape(title)}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="{html.escape(DESCRIPTION)}">
<meta property="og:title" content="{html.escape(og_title)}">
<meta property="og:description" content="{html.escape(DESCRIPTION)}">
<meta property="og:type" content="website">
<meta property="og:image" content="{og_img}">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" href="{FAVICON}">
</head>
<body>'''

PAGES = [
    ('index.html', 'OVERVIEW'),
    ('block-diagram.html', 'BLOCK DIAGRAM'),
    ('spec-atlas.html', 'SPEC ATLAS'),
    ('org-chart.html', 'ORG CHART'),
    ('framework.html', 'FRAMEWORK'),
    ('backlog.html', 'BACKLOG'),
]

TABBAR_CSS = """
.tabbar { display:flex; flex-wrap:wrap; gap:.45rem; padding:14px 16px 4px;
  font-family:'Plex Mono',monospace; }
.tabbar a { display:inline-block; font-size:.78rem; font-weight:600;
  letter-spacing:.08em; text-decoration:none; color:var(--ink-2,#5c6663);
  background:var(--panel,#ffffff); border:1.5px solid var(--line,#d3dad7);
  border-radius:999px; padding:.45rem 1rem; }
.tabbar a:hover { border-color:var(--rx,#0f766e); color:var(--rx,#0f766e); }
.tabbar a.here { background:var(--rx,#0f766e); border-color:var(--rx,#0f766e);
  color:var(--panel,#ffffff); }
"""

def nav(active_page):
    pills = ''.join(
        f'<a href="{p}"{" class=" + chr(34) + "here" + chr(34) if p == active_page else ""}>{t}</a>'
        for p, t in PAGES)
    pills += f'<a href="{REPO_URL}" target="_blank" rel="noopener">GITHUB ↗</a>'
    return f'<nav class="tabbar">{pills}</nav>'

STYLE = FONTS + """
:root {
  --bg:#eef1f0; --panel:#ffffff; --ink:#1e2423; --ink-2:#5c6663; --line:#d3dad7;
  --rx:#0f766e; --tx:#6d5bd0; --chip:#f2f5f4; --good:#19715c; --goodbg:#e7f2ee;
}
@media (prefers-color-scheme: dark) { :root {
  --bg:#161a19; --panel:#1e2423; --ink:#e8ecea; --ink-2:#96a19d; --line:#323b38;
  --rx:#34c3b5; --tx:#a795f5; --chip:#242b29; --good:#5fd4b4; --goodbg:#1d322b;
} }
:root[data-theme="light"] {
  --bg:#eef1f0; --panel:#ffffff; --ink:#1e2423; --ink-2:#5c6663; --line:#d3dad7;
  --rx:#0f766e; --tx:#6d5bd0; --chip:#f2f5f4; --good:#19715c; --goodbg:#e7f2ee;
}
:root[data-theme="dark"] {
  --bg:#161a19; --panel:#1e2423; --ink:#e8ecea; --ink-2:#96a19d; --line:#323b38;
  --rx:#34c3b5; --tx:#a795f5; --chip:#242b29; --good:#5fd4b4; --goodbg:#1d322b;
}
* { box-sizing:border-box; }
body { margin:0; background:var(--bg); color:var(--ink);
  font:16px/1.6 'Plex Sans', system-ui, sans-serif; }
.mono { font-family:'Plex Mono', monospace; }
.wrap { max-width:1080px; margin:0 auto; padding:0 1.3rem; }
.eyebrow { font-family:'Plex Mono',monospace; font-size:.74rem; letter-spacing:.14em;
  text-transform:uppercase; color:var(--rx); }
h1 { font-size:clamp(1.7rem, 4.5vw, 2.6rem); line-height:1.15; margin:.4rem 0 .8rem; text-wrap:balance; }
h2 { font-size:1.25rem; margin:2.6rem 0 .7rem; }
p { max-width:72ch; }
a { color:var(--rx); }
.sub { color:var(--ink-2); font-size:1.05rem; max-width:66ch; }
.cadence { height:22px; border:1px solid var(--line); border-radius:7px; overflow:hidden;
  position:relative; background:var(--panel); margin:1.6rem 0 .4rem; }
.cadence::before { content:''; position:absolute; inset:0;
  background:repeating-linear-gradient(90deg,
    color-mix(in srgb, var(--ink-2) 28%, transparent) 0 20px,
    color-mix(in srgb, var(--rx) 22%, var(--panel)) 20px 55px,
    color-mix(in srgb, var(--rx) 42%, var(--panel)) 55px 105px,
    color-mix(in srgb, var(--rx) 62%, var(--panel)) 105px 125px,
    var(--rx) 125px 170px,
    color-mix(in srgb, #b45309 45%, var(--panel)) 170px 180px,
    transparent 180px 210px);
  background-size:210px 100%;
  animation:flow 1.344s linear infinite; }
@keyframes flow { from { background-position:0 0; } to { background-position:-210px 0; } }
@media (prefers-reduced-motion: reduce) { .cadence::before { animation:none; } }
.cadcap { font-size:.76rem; color:var(--ink-2); margin:0 0 1rem; max-width:78ch; }
dl.mlegend { display:grid; grid-template-columns:max-content 1fr; gap:.35rem 1.1rem;
  margin:0 0 1.2rem; max-width:78ch; }
dl.mlegend dt { font-family:'Plex Mono',monospace; font-size:.72rem; letter-spacing:.06em;
  text-transform:uppercase; color:var(--rx); white-space:nowrap; padding-top:.1rem; }
dl.mlegend dd { margin:0; font-size:.85rem; color:var(--ink-2); }
.cap-motion { display:inline; } .cap-static { display:none; }
@media (prefers-reduced-motion: reduce) {
  .cap-motion { display:none; } .cap-static { display:inline; } }
.twocol { display:grid; grid-template-columns:1fr; gap:1.2rem; }
@media (min-width:840px) { .twocol { grid-template-columns:1fr 1fr; } }
.col { border:1px solid var(--line); border-radius:14px; background:var(--panel); padding:1.1rem 1.3rem; }
.col h3 { margin:.1rem 0 .5rem; font-size:1rem; }
.col p { font-size:.92rem; color:var(--ink-2); }
.col p b, .col p strong { color:var(--ink); }
blockquote.journal { border:1.5px dashed var(--line); border-left:3px solid var(--rx);
  border-radius:8px; margin:.9rem 0; padding:.7rem 1rem; font-size:.88rem;
  color:var(--ink); background:var(--chip); }
blockquote.journal footer { font-family:'Plex Mono',monospace; font-size:.68rem;
  color:var(--ink-2); margin-top:.5rem; font-style:normal; }
.chips { display:flex; flex-wrap:wrap; gap:.45rem; margin:.8rem 0; }
.chip { font-family:'Plex Mono',monospace; font-size:.74rem; background:var(--chip);
  border:1px solid var(--line); border-radius:999px; padding:.3rem .75rem; }
.cards { display:grid; grid-template-columns:1fr; gap:1rem; margin:1.2rem 0 2rem; }
@media (min-width:840px) { .cards { grid-template-columns:1fr 1fr; } }
a.card { display:block; border:1.5px solid var(--line); border-radius:14px;
  background:var(--panel); padding:1.1rem 1.3rem; text-decoration:none; color:var(--ink);
  transition:border-color .15s; }
a.card:hover { border-color:var(--rx); }
a.card .ct { font-weight:600; font-size:1.05rem; }
a.card .cd { font-size:.88rem; color:var(--ink-2); margin-top:.3rem; }
a.card .go { font-family:'Plex Mono',monospace; font-size:.74rem; color:var(--rx); margin-top:.6rem; display:block; }
.foot { border-top:1px solid var(--line); margin-top:2.5rem; padding:1.2rem 0 2rem;
  font-size:.8rem; color:var(--ink-2); }
.phase { display:flex; gap:1rem; align-items:flex-start; padding:.8rem 0;
  border-bottom:1px dotted var(--line); }
.pbadge { flex:0 0 5.4rem; text-align:center; font-family:'Plex Mono',monospace;
  font-size:.68rem; letter-spacing:.06em; border-radius:6px; padding:.25rem .4rem; margin-top:.15rem; }
.pbadge.done { background:var(--goodbg); color:var(--good); }
.pbadge.now { background:color-mix(in srgb, var(--tx) 16%, var(--panel)); color:var(--tx); }
.pbadge.next, .pbadge.later { background:var(--chip); color:var(--ink-2); }
.phase h3 { margin:0 0 .2rem; font-size:.98rem; }
.phase p { margin:0; font-size:.86rem; color:var(--ink-2); }
.mtable { overflow-x:auto; }
.mtable td.p { color:var(--accent); white-space:nowrap; }
table { border-collapse:collapse; font-size:.82rem; min-width:640px; }
th, td { text-align:left; padding:.4rem .7rem; border-bottom:1px solid var(--line); }
th { font-family:'Plex Mono',monospace; font-size:.68rem; letter-spacing:.08em;
  text-transform:uppercase; color:var(--ink-2); }
td.y { color:var(--good); font-weight:600; }
td.n { color:var(--ink-2); opacity:.5; }
.wotable td { font-size:.8rem; vertical-align:top; }
.wotable td:last-child { font-family:'Plex Mono',monospace; font-size:.72rem; color:var(--ink-2); }
.wost { font-family:'Plex Mono',monospace; font-size:.66rem; border-radius:5px; padding:.12rem .45rem; white-space:nowrap; }
.wost.ACCEPTED { background:var(--goodbg); color:var(--good); }
.wost.ISSUED { background:color-mix(in srgb, var(--tx) 16%, var(--panel)); color:var(--tx); }
.wost.RETURNED { background:var(--chip); color:var(--ink-2); }
ul.next { padding-left:1.2rem; } ul.next li { margin:.35rem 0; font-size:.92rem; }
""" + TABBAR_CSS



# D11/H4: one caption, two CSS-toggled variants.
CAD_CAPTION = '''<p class="cadcap"><span class="cap-motion">One Ethernet packet
  comes in every 67.2 nanoseconds, slowed down exactly
  20,000,000× here.</span><span class="cap-static">One Ethernet packet every
  67.2 nanoseconds — shown frozen; your system asked for reduced
  motion.</span> <span style="white-space:nowrap">Check it out in
  more detail <a href="block-diagram.html">here</a>.</span></p>'''

# T11(b): verbatim, verified against agents/journals/claude_dv_lead_agent.md
# (J-dv_lead-0010) — do not edit this text.
JOURNAL_QUOTE = '''<blockquote class="journal">“I withheld the last signature
  of the gate, and the fact that it is the last is the reason to hold it rather
  than to grant it. The work order says that on a positive verdict twenty
  specifications freeze and the gate goes to the sponsor. That framing is
  exactly the pressure a countersignature exists to resist.”
  <footer>quoted verbatim from the verification lead’s journal
  (J-dv_lead-0010), the batch-F withholding</footer></blockquote>'''

footer_repo = f'<a href="{REPO_URL}" target="_blank" rel="noopener">source on GitHub</a>'

# ---- index ------------------------------------------------------------------
jchips = ' '.join(
    f'<span class="chip">{jcounts[a]} · {label} ({a})</span>' if label != a
    else f'<span class="chip">{jcounts[a]} · {a}</span>'
    for a, label in AGENTS)

index = head_block('agentic-fpga — a trading network card built by an AI org',
                   'agentic-fpga') + f'''
<style>{STYLE}</style>
{nav('index.html')}
<div class="wrap">
  <span class="eyebrow">agentic-fpga</span>
  <h1>A trading network card, engineered end-to-end by an organization of AI agents</h1>
  <p class="sub">A 10-gigabit Ethernet network card that in simulation parses
  a stock exchange&rsquo;s data feed and tracks the order book in hardware, written in
  Hardcaml by a hierarchy of AI agents under a human sponsor who sets vision and
  direction, giving the final sign off at each stage of the project.</p>
  <div class="cadence" title="A new minimum-size packet every 67.2 nanoseconds — slowed down exactly 20,000,000× so you can watch it"></div>
  {CAD_CAPTION}


  <h2>Project details</h2>
  <div class="twocol">
    <div class="col">
      <p>When a stock exchange publishes prices, trading firms race to read them
      — and the racing happens in silicon, on network cards that decode
      messages in <b>billionths of a second</b>. This project builds the core of
      such a card: the chip logic that catches packets off a 10-gigabit wire,
      unwraps their envelopes layer by layer, checks every one for corruption,
      and hands clean market messages to a trading application.</p>
      <p>The twist: <b>one person, directing an AI workforce</b>. The project
      is conceived, directed, and gated by its human sponsor — the vision, the
      priorities, and every consequential decision are his. The engineering
      itself is carried out by an organization of AI agents working under his
      direction and under strict written rules: an architect, a hardware
      designer, a verification lead, and an independent auditor, coordinated
      by an orchestrator.</p>
      <p>The architect agent wrote the specification — 110 requirements,
      tracing to 20 modules.<br>
      The hardware design agent wrote the modules and repairs what
      verification convicts.<br>
      The verification agent wrote the comprehensive test plans and reviews
      every test line by line.<br>
      The auditor agent, blinded to the tests, seeds defects into the design;
      the tests must catch them, with expected results sealed before the
      defects exist.<br>
      The orchestrator agent routes the work and makes every commit.</p>
      <p>Everything tracked in GitHub, with each commit carrying its
      author&rsquo;s work history and full reasoning for everything it did and
      why. None of it exists without that direction — the
      agents execute; the sponsor decides. And the rules have teeth: more than
      once, an agent refused to sign off another agent’s work until it was
      repaired; once, the verification lead rejected its own manager’s defect
      report as wrong. Those refusals being possible — and
      <a href="backlog.html">on the record</a> — are the point.</p>
      {JOURNAL_QUOTE}
      <p>Start with the <a href="block-diagram.html">block diagram</a> — you
      can watch a packet arrive, byte by byte.</p>
    </div>
    <div class="col">
      <p><b>Hardcaml</b> (an OCaml hardware DSL built for high-frequency
      trading hardware), simulation-first,
      one 64-bit word per cycle at a 156.25&nbsp;MHz design clock with zero
      backpressure on the receive path. XGMII-attached 10G MAC with CRC-32,
      then ARP / IPv4 / UDP — 20 modules, every interface a compile-checked
      record, every spec frozen only after a verification countersignature that
      recomputed its contracts. Emitted Verilog is proven <b>byte-deterministic
      in CI</b> on every push; test plans precede benches; golden models must
      be anchored to an external authority. Nothing is synthesized —
      everything runs in simulation by design. The first module is under test
      now: its benches run green in CI, and each family of tests is qualified
      by a campaign of seeded defects it must catch before its results
      count. One of the five built modules was later repaired to conform
      to a freeze-time spec ruling — the process catching its own product.
      After the same arithmetic defect escaped review twice at the spec’s own
      worked example, the org replaced example-checking with exhaustive
      quantification over all 8.7 million admissible length pairs.</p>
      <p>Phase 2 feeds it reality: MoldUDP64 + NASDAQ ITCH 5.0 parsing into a
      single-symbol order book, replaying a recorded trading day packet-for-packet
      with wire-to-book latency measured in cycles.</p>
      <p>Start with the <a href="spec-atlas.html">spec atlas</a> — all 110
      requirements and the traceability matrix.</p>
    </div>
  </div>

  <h2>Why it exists</h2>
  <p>To test a proposition: that an AI organization can do <b>rigorous</b>
  engineering — not demo-grade code, but spec-first hardware development
  with an audit trail a skeptic can re-execute. The mechanism is a simple rule
  enforced by script and CI: <b>no work enters the repository without the acting
  agent’s reasoning entering beside it</b>, appended to that agent’s
  journal in the same commit. Journals are append-only; mistakes are corrected
  forward, never rewritten. The history is the experiment’s data.</p>
  <p class="cadcap">The {n_entries} journal entries — one per commit — by author:</p>
  <div class="chips">{jchips}</div>

  <h2>The tech stack</h2>
  <div class="chips">
    <span class="chip">OCaml + Hardcaml v0.17</span>
    <span class="chip">dune + expect tests</span>
    <span class="chip">GitHub Actions — the authoritative build</span>
    <span class="chip">Claude agents — an orchestrator, three leads, an independent auditor, workers spawned per work order</span>
    <span class="chip">append-only journals, mechanically enforced</span>
    <span class="chip">this site: static, Cloudflare</span>
  </div>

  <h2>Explore</h2>
  <div class="cards">
    <a class="card" href="block-diagram.html"><span class="ct">Block diagram</span>
      <span class="cd">The chip drawn from its own sources — animated traffic, a clickable
      map of all 20 modules, and the anatomy of one packet, byte by byte, with a live
      nanosecond clock.</span><span class="go">open →</span></a>
    <a class="card" href="spec-atlas.html"><span class="ct">Spec atlas</span>
      <span class="cd">All 110 requirements, the 20-module inventory, dataflow diagrams,
      and the traceability matrix — regenerated from the spec text itself, pinned at
      <span class="mono">{head_sha}</span>.</span><span class="go">open →</span></a>
    <a class="card" href="org-chart.html"><span class="ct">Org chart</span>
      <span class="cd">Who does what, who may refuse whom, and the journal rule no agent
      can escape — the org’s constitution, explorable.</span><span class="go">open →</span></a>
    <a class="card" href="backlog.html"><span class="ct">Backlog &amp; progress</span>
      <span class="cd">Every work order ever issued and its outcome, the module-by-module
      status matrix, and what happens next.</span><span class="go">open →</span></a>
    <a class="card" href="{REPO_URL}" target="_blank" rel="noopener"><span class="ct">GitHub</span>
      <span class="cd">The repository itself — every commit paired with its agent’s journal
      entry, the frozen specs, the test plans, the enforcement scripts, and the full
      append-only record this site is generated from.</span><span class="go">open ↗</span></a>
  </div>

  <div class="foot">Generated from the repository at commit
  <a class="mono" href="{REPO_URL}/commit/{head_sha}" target="_blank" rel="noopener">{head_sha}</a>
  · {gen_date} · {footer_repo} · built by
  the org’s orchestrator, like everything else here.</div>
</div>
</body></html>
'''

# ---- backlog ----------------------------------------------------------------
phases_html = ''.join(
    f'<div class="phase"><span class="pbadge {cls}">{ {"done":"DONE","now":"NOW","next":"NEXT","later":"LATER"}[cls] }</span>'
    f'<div><h3>{html.escape(t)}</h3><p>{p}</p></div></div>'
    for t, cls, p in PHASES)

def cell(v):
    return '<td class="y">✓</td>' if v else '<td class="n">—</td>'

def vcell(ver):
    if ver is None:
        return '<td class="n">\u2014</td>'
    n, m, signed = ver
    if signed:
        return '<td class="y">\u2713</td>'
    return f'<td class="p mono">{n}/{m}</td>'

mrows = ''.join(
    f'<tr><td class="mono">{mid}</td><td class="mono">{name}</td>'
    + cell(spec) + cell(rtl) + cell(plan) + cell(bench) + vcell(ver) + '</tr>'
    for mid, name, spec, rtl, plan, bench, ver in MODS)

def clean_cell(text):
    # T7: markdown links degrade to bare text while the repo is private.
    text = re.sub(r'\[([^\]]*)\]\([^)]*\)', r'\1', text)
    return re.sub(r'\*\*([^*]*)\*\*', r'<b>\1</b>', html.escape(text))

wrows = ''.join(
    f'<tr><td class="mono">{wid}</td>'
    f'<td><span class="wost {state.split()[0]}">{html.escape(state)}</span></td>'
    f'<td>{html.escape(fromto.strip())}</td><td>{clean_cell(note)}</td></tr>'
    for wid, fromto, state, note in wo_rows)

next_html = ''.join(f'<li>{html.escape(x)}</li>' for x in NEXT)

backlog = head_block('agentic-fpga — backlog & progress',
                     'agentic-fpga — backlog & progress') + f'''
<style>{STYLE}</style>
{nav('backlog.html')}
<div class="wrap">
  <span class="eyebrow">agentic-fpga / backlog</span>
  <h1>Where the program stands</h1>
  <p class="sub">The work-order ledger below is parsed verbatim from the program
  board — the same file the agents work from. The status matrix is derived from
  the spec and RTL trees; the next-steps list is the orchestrator’s summary,
  refreshed at each regeneration. Commit <span class="mono">{head_sha}</span>.</p>

  <h2>The roadmap</h2>
  {phases_html}

  <h2>Module status — {n_rtl} of 20 built</h2>
  <dl class="mlegend">
    <dt>spec frozen</dt><dd>the design contract is locked</dd>
    <dt>rtl built</dt><dd>the hardware code is written and compiling</dd>
    <dt>test plan</dt><dd>the catalogue of ways testers will try to break it</dd>
    <dt>benches</dt><dd>those tests actually running against the hardware code</dd>
    <dt>verified</dt><dd>how many of the test plan's assertions the benches have discharged so far &mdash; a check only lands with the module's signed-off verification, which no module has yet</dd>
  </dl>
  <div class="mtable"><table>
    <tr><th>id</th><th>module</th><th>spec frozen</th><th>rtl built</th><th>test plan</th><th>benches</th><th>verified</th></tr>
    {mrows}
  </table></div>

  <h2>What happens next</h2>
  <ul class="next">{next_html}</ul>

  <h2>Every work order ever issued ({len(set(r[0] for r in wo_rows))})</h2>
  <p class="sub" style="font-size:.88rem">A work order is how the orchestrator hands
  an agent a job: scope, deliverables, and what it may not touch. The agent returns;
  the orchestrator accepts or routes the dispute. Newest first. Outcomes are quoted
  verbatim from the ledger — agent-to-agent shop-talk, commit hashes and all.
  That’s deliberate: this is the raw record, not a press release.</p>
  <div class="mtable"><table class="wotable">
    <tr><th>id</th><th>state</th><th>from → to</th><th>outcome</th></tr>
    {wrows}
  </table></div>

  <div class="foot">Generated from the program board at commit
  <a class="mono" href="{REPO_URL}/commit/{head_sha}" target="_blank" rel="noopener">{head_sha}</a>
  · {gen_date} · {footer_repo} · built by
  the org’s orchestrator, like everything else here.</div>
  <!-- regenerate: python3 site/build.py -->
</div>
</body></html>
'''

# ---- markdown rendering (docs/FRAMEWORK.md, rendered) -----------------------
# Minimal converter for exactly the markdown subset the doc pages use (h1-h4,
# hr, tables, flat ul/ol, bold/italic/inline-code, internal #anchors; external
# links degrade to bare text per T7 while the repo is private). If the doc
# grows a construct this subset misses, the page shows it as plain text
# rather than silently dropping it — check the render after edits.

def _slug(text):
    s = re.sub(r'[^a-z0-9 -]', '', text.lower())
    return re.sub(r'-+', '-', s.replace(' ', '-')).strip('-')

def _inline(text):
    t = html.escape(text, quote=False)
    t = re.sub(r'`([^`]+)`', r'<code>\1</code>', t)
    t = re.sub(r'\*\*((?:[^*]|\*(?!\*))+)\*\*', r'<b>\1</b>', t)
    t = re.sub(r'(?<!\*)\*([^*]+)\*(?!\*)', r'<i>\1</i>', t)
    t = re.sub(r'\[([^\]]*)\]\((#[^)]*)\)', r'<a href="\2">\1</a>', t)
    t = re.sub(r'\[([^\]]*)\]\([^)]*\)', r'\1', t)
    return t

def md_to_html(md):
    out, para, lst, tbl, li_buf = [], [], None, [], []
    fence, fence_buf, bq = False, [], []
    def flush_para():
        if para:
            out.append('<p>' + _inline(' '.join(para)) + '</p>'); para.clear()
    def flush_bq():
        if bq:
            paras, cur = [], []
            for l in bq:
                if l.strip(): cur.append(l)
                elif cur: paras.append(cur); cur = []
            if cur: paras.append(cur)
            out.append('<blockquote>' + ''.join(
                '<p>' + _inline(' '.join(p)) + '</p>' for p in paras) + '</blockquote>')
            bq.clear()
    def flush_li():
        if li_buf:
            out.append(f'<li>{_inline(" ".join(li_buf))}</li>'); li_buf.clear()
    def flush_list():
        nonlocal lst
        flush_li()
        if lst: out.append(f'</{lst}>'); lst = None
    def flush_table():
        if tbl:
            head, *body = [r for r in tbl if not re.match(r'^\|[\s:|-]+\|$', r)]
            cells = lambda r: [c.strip() for c in r.strip().strip('|').split('|')]
            out.append('<div class="mtable"><table><tr>' +
                       ''.join(f'<th>{_inline(c)}</th>' for c in cells(head)) + '</tr>' +
                       ''.join('<tr>' + ''.join(f'<td>{_inline(c)}</td>' for c in cells(r)) +
                               '</tr>' for r in body) + '</table></div>')
            tbl.clear()
    for line in md.split('\n'):
        if line.startswith('```'):
            if fence:
                out.append('<pre class="fence"><code>' +
                           html.escape('\n'.join(fence_buf)) + '</code></pre>')
                fence_buf.clear(); fence = False
            else:
                flush_para(); flush_list(); flush_bq(); fence = True
            continue
        if fence:
            fence_buf.append(line); continue
        if line.startswith('>'):
            flush_para(); flush_list()
            bq.append(line[2:] if line.startswith('> ') else line[1:])
            continue
        elif bq and not line.strip():
            flush_bq()
        elif bq:
            flush_bq()
        if tbl and not line.startswith('|'): flush_table()
        m = re.match(r'^(#{1,4}) (.*)$', line)
        if m:
            flush_para(); flush_list()
            n = len(m.group(1)); txt = m.group(2)
            out.append(f'<h{n} id="{_slug(txt)}">{_inline(txt)}</h{n}>')
        elif line.strip() == '---':
            flush_para(); flush_list(); out.append('<hr>')
        elif line.startswith('|'):
            flush_para(); flush_list(); tbl.append(line)
        elif re.match(r'^- ', line):
            flush_para()
            if lst != 'ul': flush_list(); out.append('<ul>'); lst = 'ul'
            else: flush_li()
            li_buf.append(line[2:])
        elif re.match(r'^\d+\. ', line):
            flush_para()
            if lst != 'ol': flush_list(); out.append('<ol>'); lst = 'ol'
            else: flush_li()
            li_buf.append(re.sub(r'^[0-9]+[.] ', '', line))
        elif not line.strip():
            flush_para(); flush_list()
        else:
            if lst and line.startswith('  '):
                li_buf.append(line.strip())
            else:
                para.append(line.strip())
    if fence and fence_buf:
        out.append('<pre class="fence"><code>' +
                   html.escape('\n'.join(fence_buf)) + '</code></pre>')
    flush_para(); flush_list(); flush_bq(); flush_table()
    return '\n'.join(out)

PROCESS_CSS = """
.doc h1 { margin-top:1.2rem; }
.doc h2 { font-size:1.35rem; margin:2.8rem 0 .7rem; border-top:1px solid var(--line); padding-top:1.6rem; }
.doc h3 { font-size:1.08rem; margin:2rem 0 .5rem; }
.doc h4 { font-size:.95rem; margin:1.5rem 0 .4rem; color:var(--ink-2);
  font-family:'Plex Mono',monospace; letter-spacing:.04em; }
.doc p, .doc li { max-width:76ch; }
.doc li { margin:.3rem 0; }
.doc hr { border:0; border-top:1px solid var(--line); margin:2rem 0; }
.doc pre.fence { font-family:'Plex Mono',monospace; font-size:.82em; background:var(--chip);
  border:1px solid var(--line); border-radius:6px; padding:.8rem 1rem; margin:1rem 0;
  overflow-x:auto; max-width:86ch; line-height:1.5; }
.doc pre.fence code { background:none; padding:0; font-size:1em; }
.doc blockquote { border-left:3px solid var(--line); margin:1rem 0; padding:.2rem 0 .2rem 1rem;
  color:var(--ink-2); max-width:74ch; }
.doc code { font-family:'Plex Mono',monospace; font-size:.86em; background:var(--chip);
  border:1px solid var(--line); border-radius:5px; padding:.06em .35em; }
.doc .mtable { overflow-x:auto; margin:.8rem 0 1.4rem; }
.doc .mtable table { border-collapse:collapse; font-size:.9rem; min-width:480px; }
.doc .mtable th, .doc .mtable td { border:1px solid var(--line); padding:.45rem .7rem;
  text-align:left; vertical-align:top; }
.doc .mtable th { background:var(--chip); font-family:'Plex Mono',monospace;
  font-size:.74rem; letter-spacing:.06em; text-transform:uppercase; }
"""

# ---- the framework page (docs/FRAMEWORK.md + its figures) -------------------
# The one-pager text renders verbatim; each section gets the figure(s) from
# site/framework_figs.py that encode the mechanism it describes. The permission
# matrix sits after the 'Who does what' intro, ahead of the seat list, because
# it is the table that list would otherwise force a reader to build; every
# other figure follows its section's full text.

framework_md = open(os.path.join(ROOT, 'docs', 'FRAMEWORK.md')).read()
fw_parts = []
for chunk in re.split(r'\n(?=## )', framework_md):
    title = chunk.split('\n', 1)[0].lstrip('#').strip()
    key = title if chunk.startswith('## ') else '__intro__'
    figs = ''.join(FIGS.get(key, []))
    if key == 'Who does what' and '\n- ' in chunk:
        cut = chunk.index('\n- ')
        fw_parts.append(md_to_html(chunk[:cut]) + figs + md_to_html(chunk[cut + 1:]))
    else:
        fw_parts.append(md_to_html(chunk) + figs)
framework = head_block('agentic-fpga — the framework',
                       'agentic-fpga — how the multi-agent framework works, on one page') + f'''
<style>{STYLE}{PROCESS_CSS}{FRAMEWORK_CSS}</style>
{nav('framework.html')}
<div class="wrap doc">
  <span class="eyebrow">agentic-fpga / framework</span>
  {''.join(fw_parts)}
  <div class="foot">Text rendered verbatim from
  <span class="mono">docs/FRAMEWORK.md</span> at commit
  <a class="mono" href="{REPO_URL}/commit/{head_sha}" target="_blank" rel="noopener">{head_sha}</a>
  · {gen_date} · the one-pager is the sponsor's, imported unchanged.</div>
  <!-- regenerate: python3 site/build.py -->
</div>
</body></html>
'''

open(os.path.join(PUB, 'index.html'), 'w').write(index)
open(os.path.join(PUB, 'backlog.html'), 'w').write(backlog)
open(os.path.join(PUB, 'framework.html'), 'w').write(framework)

# ---- site chrome on the artifact pages (idempotent) -------------------------
CHROME_START = '<!-- site-chrome-start -->'
CHROME_END = '<!-- site-chrome-end -->'

ART = [
    ('block-diagram.html', 'agentic-fpga — block diagram'),
    ('spec-atlas.html', 'agentic-fpga — spec atlas'),
    ('org-chart.html', 'agentic-fpga — org chart'),
]

def art_nav(self_page):
    return f'''{CHROME_START}
<style>{TABBAR_CSS}</style>
{nav(self_page)}
{CHROME_END}'''

for page, title in ART:
    p = os.path.join(PUB, page)
    h = open(p).read()
    # strip any previous chrome (marked or legacy unmarked nav)
    h = re.sub(re.escape(CHROME_START) + r'.*?' + re.escape(CHROME_END), '', h, flags=re.S)
    # head + title: give artifact pages the shared metadata head and house title
    h = re.sub(r'^(<!doctype html>.*?<body>)?\s*<title>[^<]*</title>',
               lambda m: head_block(title, title), h, count=1, flags=re.S | re.I)
    # journal strip on the org chart (H3): site-added framing, live counts
    if page == 'org-chart.html':
        strip_chips = ' '.join(
            f'<span style="display:inline-block;background:#f2f5f4;border-radius:6px;padding:.15rem .55rem;margin:.15rem .2rem;font-family:monospace;font-size:.72rem">{jcounts[a]} · {a}</span>'
            for a, _ in AGENTS)
        strip = f'''
<div style="max-width:1100px;margin:3.2rem auto 0;padding:.9rem 1.2rem;border:1.5px dashed #d3dad7;border-radius:12px;font-family:system-ui,sans-serif;font-size:.85rem;line-height:1.55;color:#5c6663">
<strong style="color:#1e2423">The journal rule.</strong> No agent touches the design without leaving its reasoning on the record: every commit pairs the work with a pure append to that agent’s journal — trigger, inputs, options considered, evidence, and an exact list of files — enforced by script and re-checked in CI. {n_entries} entries so far, one per commit: {strip_chips}
</div>'''
        # replace a previously injected strip, else append before </body> or at end
        h = re.sub(r'\n<div style="max-width:1100px;margin:3\.2rem[^\x00]*?</div>', '', h, count=1)
        h = h + strip
    # insert nav chrome right after the first </style>
    j = h.find('</style>') + len('</style>')
    h = h[:j] + '\n' + art_nav(page) + h[j:]
    open(p, 'w').write(h)

print(f'site built · {n_commits} commits · {n_entries} entries · {len(wo_rows)} WOs · '
      f'{n_attack} attack rows · {n_rtl}/20 RTL · matrix derived from trees')
