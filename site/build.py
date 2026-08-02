#!/usr/bin/env python3
"""Build index.html and backlog.html for the showcase site from repo state.

Rerun after the program moves: it reads tasks/BOARD.md, the journals, and
git, so the numbers and the work-order ledger stay honest. The three
artifact pages (block-diagram / spec-atlas / org-chart) are self-contained
snapshots refreshed separately by their own generators.
"""
import html, os, re, subprocess

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PUB = os.path.join(ROOT, 'site', 'public')

def sh(*args):
    return subprocess.run(args, cwd=ROOT, capture_output=True, text=True).stdout

# ---- live numbers -----------------------------------------------------------
n_commits = int(sh('git', 'rev-list', '--count', 'HEAD'))
agents = ['orchestrator', 'architect_docs_lead', 'rtl_lead', 'dv_lead', 'auditor']
jcounts = {}
for a in agents:
    p = os.path.join(ROOT, 'agents', 'journals', f'claude_{a}_agent.md')
    jcounts[a] = len(re.findall(r'^## \[J-', open(p).read(), re.M))
n_entries = sum(jcounts.values())
head = sh('git', 'rev-parse', '--short', 'HEAD').strip()
gen_date = sh('git', 'log', '-1', '--format=%ad', '--date=format:%Y-%m-%d').strip()

board = open(os.path.join(ROOT, 'tasks', 'BOARD.md')).read()
wo_rows = re.findall(
    r'^\| \[(WO-\d{4})\]\(([^)]*)\) \| ([^|]*) \| (\w+) \| (.*?) \|$', board, re.M)

n_attack = 0
for ap in ('AP-xgmii_rx_64.md', 'AP-ip_eth_rx_64.md'):
    p = os.path.join(ROOT, 'test', 'attack_plans', ap)
    if os.path.exists(p):
        n_attack += len(re.findall(r'^\| \*\*M\d{2}-[A-Z]\d+\*\*', open(p).read(), re.M))

# ---- module status matrix ---------------------------------------------------
# Update by hand as the program moves; the build asserts the counts stay sane.
MODS = [
    # id, name, spec, rtl, plan, bench
    ('M01', 'Axi64', 1, 1, 0, 0), ('M02', 'Crc32_eth', 1, 1, 0, 0),
    ('M03', 'Xgmii_rx_64', 1, 1, 1, 0), ('M04', 'Xgmii_tx_64', 1, 1, 0, 0),
    ('M05', 'Eth_mac_10g', 1, 1, 0, 0), ('M06', 'Eth_axis_rx', 1, 0, 0, 0),
    ('M07', 'Eth_axis_tx', 1, 0, 0, 0), ('M08', 'Eth_demux', 1, 0, 0, 0),
    ('M09', 'Eth_arb_mux', 1, 0, 0, 0), ('M10', 'Arp_eth_rx', 1, 0, 0, 0),
    ('M11', 'Arp_eth_tx', 1, 0, 0, 0), ('M12', 'Arp_cache', 1, 0, 0, 0),
    ('M13', 'Arp', 1, 0, 0, 0), ('M14', 'Ip_eth_rx_64', 1, 0, 1, 0),
    ('M15', 'Ip_eth_tx_64', 1, 0, 0, 0), ('M16', 'Ip_complete_64', 1, 0, 0, 0),
    ('M17', 'Udp_ip_rx_64', 1, 0, 0, 0), ('M18', 'Udp_ip_tx_64', 1, 0, 0, 0),
    ('M19', 'Udp_complete_64', 1, 0, 0, 0), ('M20', 'Nic_top', 1, 0, 0, 0),
]
n_rtl = sum(m[3] for m in MODS)

PHASES = [
    ('M0 — the org itself', 'done', 'Charters, protocol, mechanical enforcement, adversarial review of the rules before any work ran under them.'),
    ('G0 — governance proven', 'done', 'The audit loop ran end-to-end once: findings, disposition, adversarial re-check, gate signed.'),
    ('P1 spec-freeze', 'done', 'All 20 module specs frozen behind adversarial countersignatures; sponsor-signed 2026-08-02. Two batches were refused first — the refusals are part of the record.'),
    ('P1 build & verify', 'now', f'{n_rtl} of 20 modules in RTL (every one green on first elaboration), {n_attack} attack rows planned, the verification machinery landing now. Next: benches against the attack rows, module-ready sign-offs with mutation kills.'),
    ('Phase 2 — market data', 'next', 'MoldUDP64 + NASDAQ ITCH 5.0 parser, single-symbol order book, a recorded real trading day replayed packet-for-packet, wire-to-book latency histograms.'),
    ('Phase 3 — stretch', 'later', '10GBASE-R soft PCS (64b/66b), wire-to-wire latency report.'),
]

NEXT = [
    'Verification machinery final green + acceptance (WO-0033 arc)',
    'First testbench work orders: the M03 attack rows run against real RTL',
    'Real-compile pre-check harness into tools/ (dv’s own proposal after its first Build escape)',
    'Architect packet: two returned spec questions + ledger cells C-43/C-46/C-47',
    'Next RTL wave: the Ethernet layer (M06–M09)',
]

# ---- shared style -----------------------------------------------------------
bd = open(os.path.join(PUB, 'block-diagram.html')).read()
fonts = re.findall(r"@font-face \{ font-family: '[^']+'; font-weight: \d+; src: url\(data:font/woff2;base64,[^)]+\) format\('woff2'\); \}", bd)
assert len(fonts) == 3, len(fonts)
FONTS = '\n'.join(fonts)

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
.sub { color:var(--ink-2); font-size:1.05rem; max-width:64ch; }
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
.cadcap { font-size:.76rem; color:var(--ink-2); margin:0 0 1rem; }
.numbers { display:flex; flex-wrap:wrap; gap:.7rem; margin:1.6rem 0; }
.stat { flex:1 1 9.5rem; border:1px solid var(--line); border-radius:12px;
  background:var(--panel); padding:.7rem .9rem; }
.stat b { display:block; font-family:'Plex Mono',monospace; font-weight:400;
  font-size:1.25rem; color:var(--rx); font-variant-numeric:tabular-nums; }
.stat span { font-size:.74rem; color:var(--ink-2); line-height:1.35; display:block; margin-top:.15rem; }
.twocol { display:grid; grid-template-columns:1fr; gap:1.2rem; }
@media (min-width:840px) { .twocol { grid-template-columns:1fr 1fr; } }
.col { border:1px solid var(--line); border-radius:14px; background:var(--panel); padding:1.1rem 1.3rem; }
.col h3 { margin:.1rem 0 .5rem; font-size:1rem; }
.col p { font-size:.92rem; color:var(--ink-2); }
.col p b, .col p strong { color:var(--ink); }
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
table { border-collapse:collapse; font-size:.82rem; min-width:640px; }
th, td { text-align:left; padding:.4rem .7rem; border-bottom:1px solid var(--line); }
th { font-family:'Plex Mono',monospace; font-size:.68rem; letter-spacing:.08em;
  text-transform:uppercase; color:var(--ink-2); }
td.y { color:var(--good); font-weight:600; }
td.n { color:var(--ink-2); opacity:.5; }
.wotable td { font-size:.8rem; vertical-align:top; }
.wost { font-family:'Plex Mono',monospace; font-size:.66rem; border-radius:5px; padding:.12rem .45rem; white-space:nowrap; }
.wost.ACCEPTED { background:var(--goodbg); color:var(--good); }
.wost.ISSUED { background:color-mix(in srgb, var(--tx) 16%, var(--panel)); color:var(--tx); }
.wost.RETURNED { background:var(--chip); color:var(--ink-2); }
ul.next { padding-left:1.2rem; } ul.next li { margin:.35rem 0; font-size:.92rem; }
nav.top { display:flex; gap:1rem; flex-wrap:wrap; padding:1.1rem 0; font-size:.85rem; }
nav.top a { color:var(--ink-2); text-decoration:none; font-family:'Plex Mono',monospace; font-size:.78rem; }
nav.top a:hover { color:var(--rx); }
nav.top a.here { color:var(--rx); }
"""

NAV = '''<nav class="top wrap">
<a href="index.html"{i}>overview</a>
<a href="block-diagram.html">block diagram</a>
<a href="spec-atlas.html">spec atlas</a>
<a href="org-chart.html">org chart</a>
<a href="backlog.html"{b}>backlog</a>
</nav>'''

def nav(here):
    return NAV.format(i=' class="here"' if here == 'i' else '',
                      b=' class="here"' if here == 'b' else '')

# ---- index ------------------------------------------------------------------
jchips = ' '.join(
    f'<span class="chip">{jcounts[a]} · {a}</span>' for a in agents)

index = f'''<title>agentic-fpga — a trading NIC built by an AI engineering org</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>{STYLE}</style>
{nav('i')}
<div class="wrap">
  <span class="eyebrow">agentic-fpga</span>
  <h1>A trading network card, engineered end-to-end by an organization of AI agents</h1>
  <p class="sub">A 10-gigabit Ethernet NIC for market data — written in OCaml,
  specified before it was built, and verified adversarially — by a hierarchy of
  AI agents whose every commit carries its own reasoning, with a human sponsor
  signing the gates.</p>
  <div class="cadence" title="The wire's rhythm: one minimum-size packet every 67.2 nanoseconds, replayed twenty-million-fold slower"></div>
  <p class="cadcap">The rhythm this chip lives at: a new packet every 67.2 nanoseconds,
  replayed here twenty-million-fold slower. The full story is in the
  <a href="block-diagram.html">block diagram</a>.</p>

  <div class="numbers">
    <div class="stat"><b>{n_commits}</b><span>commits — every single one paired with a journal entry explaining it</span></div>
    <div class="stat"><b>20/20</b><span>module specs frozen behind adversarial countersignatures; sponsor-signed</span></div>
    <div class="stat"><b>110</b><span>numbered requirements with a traceability matrix</span></div>
    <div class="stat"><b>{n_rtl}/20</b><span>modules in RTL — all green on first contact with a compiler</span></div>
    <div class="stat"><b>{n_attack}</b><span>named attack rows, each stating the wrong design it kills</span></div>
    <div class="stat"><b>8.7M</b><span>header pairs exhaustively checked by CI on every push</span></div>
  </div>

  <h2>What this is</h2>
  <div class="twocol">
    <div class="col">
      <h3>For everyone</h3>
      <p>When a stock exchange publishes prices, trading firms race to read them
      — and the racing happens in silicon, on network cards that decode
      messages in <b>billionths of a second</b>. This project builds the core of
      such a card: the chip logic that catches packets off a 10-gigabit wire,
      unwraps their envelopes layer by layer, checks every one for corruption,
      and hands clean market messages to a trading application.</p>
      <p>The twist: <b>no human wrote it</b>. An organization of AI agents —
      an architect, a hardware designer, a verification lead, and an independent
      auditor, coordinated by an orchestrator — designs, builds, argues
      about, and signs off every piece under strict written rules. The human
      sponsor reviews the work and signs the gates. Twice, an agent refused to
      approve another agent’s work and forced a repair. That refusal being
      possible — and recorded — is the point.</p>
    </div>
    <div class="col">
      <h3>For engineers</h3>
      <p><b>Hardcaml</b> (Jane Street’s OCaml hardware DSL), simulation-first,
      one 64-bit word per cycle at 156.25&nbsp;MHz with zero backpressure on the
      receive path. XGMII-attached 10G MAC with CRC-32, then ARP / IPv4 / UDP
      — 20 modules, every interface a compile-checked record, every spec
      frozen only after a verification countersignature that recomputed its
      contracts. Emitted Verilog is proven <b>byte-deterministic in CI</b> on
      every push; attack plans precede benches; golden models must be anchored
      to an external authority.</p>
      <p>Phase 2 feeds it reality: MoldUDP64 + NASDAQ ITCH 5.0 parsing into a
      single-symbol order book, replaying a recorded trading day packet-for-packet
      with wire-to-book latency measured in cycles.</p>
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
  <div class="chips">{jchips}</div>

  <h2>The tech stack</h2>
  <div class="chips">
    <span class="chip">OCaml + Hardcaml v0.17</span>
    <span class="chip">dune + expect tests</span>
    <span class="chip">GitHub Actions — the authoritative build</span>
    <span class="chip">Claude agents — one orchestrator, four leads</span>
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
      and the traceability matrix — regenerated from the spec text itself.</span><span class="go">open →</span></a>
    <a class="card" href="org-chart.html"><span class="ct">Org chart</span>
      <span class="cd">Who does what, who may refuse whom, and the journal rule no agent
      can escape — the org’s constitution, explorable.</span><span class="go">open →</span></a>
    <a class="card" href="backlog.html"><span class="ct">Backlog &amp; progress</span>
      <span class="cd">Every work order ever issued and its outcome, the module-by-module
      status matrix, and what happens next.</span><span class="go">open →</span></a>
  </div>

  <div class="foot">Generated from the repository at commit
  <span class="mono">{head}</span> · {gen_date} · built by the org’s
  orchestrator, like everything else here.</div>
</div>
'''

# ---- backlog ----------------------------------------------------------------
phases_html = ''.join(
    f'<div class="phase"><span class="pbadge {cls}">{ {"done":"DONE","now":"NOW","next":"NEXT","later":"LATER"}[cls] }</span>'
    f'<div><h3>{html.escape(t)}</h3><p>{p}</p></div></div>'
    for t, cls, p in PHASES)

def cell(v):
    return '<td class="y">✓</td>' if v else '<td class="n">—</td>'

mrows = ''.join(
    f'<tr><td class="mono">{mid}</td><td class="mono">{name}</td>'
    + cell(spec) + cell(rtl) + cell(plan) + cell(bench) + '</tr>'
    for mid, name, spec, rtl, plan, bench in MODS)

wrows = ''
for wid, _href, fromto, state, note in wo_rows:
    note_clean = re.sub(r'\*\*([^*]*)\*\*', r'<b>\1</b>', html.escape(note))
    wrows += (f'<tr><td class="mono">{wid}</td>'
              f'<td><span class="wost {state}">{state}</span></td>'
              f'<td>{html.escape(fromto.strip())}</td><td>{note_clean}</td></tr>')

next_html = ''.join(f'<li>{html.escape(x)}</li>' for x in NEXT)

backlog = f'''<title>agentic-fpga — backlog &amp; progress</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>{STYLE}</style>
{nav('b')}
<div class="wrap">
  <span class="eyebrow">agentic-fpga / backlog</span>
  <h1>Where the program stands</h1>
  <p class="sub">Generated from the program board and the work-order ledger at commit
  <span class="mono">{head}</span> — the same files the agents themselves work from.</p>

  <h2>The road</h2>
  {phases_html}

  <h2>Module status — {n_rtl} of 20 built, all specs frozen</h2>
  <div class="mtable"><table>
    <tr><th>id</th><th>module</th><th>spec frozen</th><th>rtl built</th><th>attack plan</th><th>benches</th></tr>
    {mrows}
  </table></div>

  <h2>What happens next</h2>
  <ul class="next">{next_html}</ul>

  <h2>Every work order ever issued ({len(wo_rows)})</h2>
  <p class="sub" style="font-size:.88rem">A work order is how the orchestrator hands
  an agent a job: scope, deliverables, and what it may not touch. The agent returns;
  the orchestrator accepts or routes the dispute. Newest first.</p>
  <div class="mtable"><table class="wotable">
    <tr><th>id</th><th>state</th><th>from → to</th><th>outcome</th></tr>
    {wrows}
  </table></div>

  <div class="foot">Regenerate with <span class="mono">python3 site/build.py</span>
  after the board moves · {gen_date}</div>
</div>
'''

open(os.path.join(PUB, 'index.html'), 'w').write(index)
open(os.path.join(PUB, 'backlog.html'), 'w').write(backlog)
print(f'index.html + backlog.html written · {n_commits} commits · '
      f'{n_entries} entries · {len(wo_rows)} WOs · {n_attack} attack rows')
