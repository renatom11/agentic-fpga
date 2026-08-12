# Hand-authored SVG figures for the FRAMEWORK page (site/public/framework.html).
# One figure per block of docs/FRAMEWORK.md, each drawing the mechanism the
# paragraph describes — not an illustration of its name. All strokes/fills ride
# the site's CSS variables (classes below), so every figure adapts to light and
# dark themes with no duplicated art. Consumed by site/build.py.

FRAMEWORK_CSS = """
:root { --bad:#b0433d; }
@media (prefers-color-scheme: dark) { :root { --bad:#e07a74; } }
.fig { margin:2.4rem 0 2.9rem; }
.fig svg { max-width:100%; height:auto; display:block; }
.fig figcaption { font-family:'Plex Mono',monospace; font-size:.76rem;
  color:var(--ink-2); margin-top:.7rem; letter-spacing:.03em; line-height:1.55;
  max-width:88ch; }
.fx-box  { fill:var(--panel); stroke:var(--line); stroke-width:1.5; }
.fx-boxs { fill:var(--panel); stroke:var(--ink); stroke-width:1.6; }
.fx-boxa { fill:var(--panel); stroke:var(--rx); stroke-width:1.8; }
.fx-boxp { fill:var(--panel); stroke:var(--tx); stroke-width:1.6; }
.fx-boxi { fill:var(--chip); stroke:var(--line); stroke-width:1.1; }
.fx-ghost { fill:none; stroke:var(--ink-2); stroke-width:1.3; stroke-dasharray:5 4; }
.fx-ln  { stroke:var(--ink-2); stroke-width:1.4; fill:none; }
.fx-lnq { stroke:var(--line); stroke-width:1.4; fill:none; }
.fx-lna { stroke:var(--rx); stroke-width:1.6; fill:none; }
.fx-lnp { stroke:var(--tx); stroke-width:1.4; fill:none; }
.fx-lnb { stroke:var(--bad); stroke-width:1.5; fill:none; }
.fx-dash { stroke-dasharray:6 5; }
.fx-t   { fill:var(--ink); font:600 12.5px 'Plex Mono',monospace; }
.fx-t2  { fill:var(--ink-2); font:500 11px 'Plex Mono',monospace; }
.fx-t3  { fill:var(--ink-2); font:500 10px 'Plex Mono',monospace; }
.fx-ta  { fill:var(--rx); font:700 11px 'Plex Mono',monospace; }
.fx-tp  { fill:var(--tx); font:700 11px 'Plex Mono',monospace; }
.fx-tg  { fill:var(--good); font:700 11px 'Plex Mono',monospace; }
.fx-tbad { fill:var(--bad); font:700 11px 'Plex Mono',monospace; }
.fx-mk  { fill:var(--ink-2); }
.fx-mka { fill:var(--rx); }
.fx-mkp { fill:var(--tx); }
.fx-mkb { fill:var(--bad); }
.fx-mkg { fill:var(--good); }
.fx-fillm { fill:var(--rx); opacity:.16; }
.fx-commit { fill:var(--chip); stroke:var(--ink-2); stroke-width:1; }
"""

def _mk(mid, cls='fx-mk'):
    return (f'<marker id="{mid}" viewBox="0 0 10 10" refX="9" refY="5" '
            f'markerWidth="6.5" markerHeight="6.5" orient="auto-start-reverse">'
            f'<path d="M0,0 L10,5 L0,10 z" class="{cls}"/></marker>')

def _fig(svg, caption, aria):
    return (f'<figure class="fig"><svg role="img" aria-label="{aria}" '
            f'{svg}</svg><figcaption>{caption}</figcaption></figure>')

# ---- F1 · the founding principle: memory lives in the repository ------------
_f1_chain = ''.join(
    f'<rect x="{x}" y="258" width="9" height="9" rx="2" class="fx-commit"/>'
    for x in range(70, 810, 38))
F1 = _fig(
    f'''viewBox="0 0 880 322">
<defs>{_mk('aF1')}{_mk('aF1a', 'fx-mka')}</defs>
<rect x="40" y="34" width="200" height="60" rx="10" class="fx-box"/>
<text x="140" y="60" text-anchor="middle" class="fx-t">AGENT SESSION 1</text>
<text x="140" y="80" text-anchor="middle" class="fx-t3">spawned &#8594; works &#8594; gone</text>
<rect x="340" y="34" width="200" height="60" rx="10" class="fx-box"/>
<text x="440" y="60" text-anchor="middle" class="fx-t">AGENT SESSION 2</text>
<text x="440" y="80" text-anchor="middle" class="fx-t3">spawned &#8594; works &#8594; gone</text>
<rect x="640" y="34" width="200" height="60" rx="10" class="fx-box"/>
<text x="740" y="60" text-anchor="middle" class="fx-t">AGENT SESSION 3</text>
<text x="740" y="80" text-anchor="middle" class="fx-t3">spawned &#8594; works &#8594; gone</text>
<line x1="248" y1="64" x2="332" y2="64" class="fx-lnb fx-dash"/>
<text x="290" y="69" text-anchor="middle" class="fx-tbad" font-size="17">&#10005;</text>
<text x="290" y="110" text-anchor="middle" class="fx-tbad" font-size="10">forgets</text>
<line x1="548" y1="64" x2="632" y2="64" class="fx-lnb fx-dash"/>
<text x="590" y="69" text-anchor="middle" class="fx-tbad" font-size="17">&#10005;</text>
<text x="590" y="110" text-anchor="middle" class="fx-tbad" font-size="10">forgets</text>
<rect x="40" y="200" width="800" height="82" rx="12" class="fx-boxa"/>
<text x="440" y="226" text-anchor="middle" class="fx-ta" font-size="13">THE REPOSITORY</text>
<text x="440" y="246" text-anchor="middle" class="fx-t2">roles &#183; rules &#183; work orders &#183; decisions &#183; evidence &#8212; everything as files</text>
{_f1_chain}
<line x1="140" y1="98" x2="140" y2="196" class="fx-ln" marker-end="url(#aF1)"/>
<text x="150" y="140" class="fx-t3">writes: commit +</text>
<text x="150" y="153" class="fx-t3">journal entry</text>
<line x1="390" y1="196" x2="390" y2="98" class="fx-lna" marker-end="url(#aF1a)"/>
<text x="382" y="140" text-anchor="end" class="fx-t3">reads: rehydrates</text>
<text x="382" y="153" text-anchor="end" class="fx-t3">from files alone</text>
<line x1="490" y1="98" x2="490" y2="196" class="fx-ln" marker-end="url(#aF1)"/>
<line x1="690" y1="196" x2="690" y2="98" class="fx-lna" marker-end="url(#aF1a)"/>
<line x1="790" y1="98" x2="790" y2="196" class="fx-ln" marker-end="url(#aF1)"/>
''',
    'The founding principle. Agents are ephemeral and nothing carries between '
    'sessions directly (&#10005;). The only channel from one session to the next '
    'is the repository: each session writes its work and its reasoning down, and '
    'the next one reconstructs the entire program state from files alone.',
    'Agent sessions cannot pass memory to each other directly; each writes '
    'commits and journal entries into the repository, and later sessions '
    'rehydrate from those files.')

# ---- F2 · the two enforcers -------------------------------------------------
F2 = _fig(
    f'''viewBox="0 0 880 344">
<defs>{_mk('aF2')}{_mk('aF2b', 'fx-mkb')}{_mk('aF2g', 'fx-mkg')}</defs>
<rect x="30" y="20" width="310" height="32" rx="8" class="fx-boxi"/>
<text x="185" y="41" text-anchor="middle" class="fx-t3">one agent per commit &#8212; one answerable author</text>
<rect x="30" y="82" width="160" height="64" rx="10" class="fx-box"/>
<text x="110" y="106" text-anchor="middle" class="fx-t">A SEAT'S CHANGE</text>
<text x="110" y="123" text-anchor="middle" class="fx-t3">work files +</text>
<text x="110" y="136" text-anchor="middle" class="fx-t3">its journal append</text>
<rect x="225" y="82" width="160" height="64" rx="10" class="fx-boxp"/>
<text x="305" y="104" text-anchor="middle" class="fx-tp" font-size="12">GATE 1 &#183; SCRIPT</text>
<text x="305" y="122" text-anchor="middle" class="fx-t3">checks every rule</text>
<text x="305" y="135" text-anchor="middle" class="fx-t3">before saving</text>
<rect x="420" y="82" width="110" height="64" rx="10" class="fx-box"/>
<text x="475" y="110" text-anchor="middle" class="fx-t">COMMIT</text>
<text x="475" y="127" text-anchor="middle" class="fx-t3">saved</text>
<rect x="565" y="82" width="160" height="64" rx="10" class="fx-boxp"/>
<text x="645" y="104" text-anchor="middle" class="fx-tp" font-size="12">GATE 2 &#183; CI</text>
<text x="645" y="122" text-anchor="middle" class="fx-t3">re-runs all rules over</text>
<text x="645" y="135" text-anchor="middle" class="fx-t3">the entire history</text>
<rect x="760" y="82" width="100" height="64" rx="10" class="fx-boxs"/>
<text x="810" y="110" text-anchor="middle" class="fx-tg" font-size="12">MAIN LINE</text>
<text x="810" y="127" text-anchor="middle" class="fx-t3" font-size="9.5">official version</text>
<line x1="192" y1="114" x2="221" y2="114" class="fx-ln" marker-end="url(#aF2)"/>
<line x1="387" y1="114" x2="416" y2="114" class="fx-ln" marker-end="url(#aF2)"/>
<text x="402" y="104" text-anchor="middle" class="fx-t3">&#10003;</text>
<line x1="532" y1="114" x2="561" y2="114" class="fx-ln" marker-end="url(#aF2)"/>
<text x="547" y="104" text-anchor="middle" class="fx-t3">push</text>
<line x1="727" y1="114" x2="756" y2="114" class="fx-ln" marker-end="url(#aF2g)"/>
<text x="741" y="104" text-anchor="middle" class="fx-tg">&#10003;</text>
<line x1="305" y1="148" x2="305" y2="196" class="fx-lnb" marker-end="url(#aF2b)"/>
<text x="305" y="216" text-anchor="middle" class="fx-tbad" font-size="10.5">&#10005; refused outright &#8212; a rule-breaking</text>
<text x="305" y="230" text-anchor="middle" class="fx-tbad" font-size="10.5">change cannot even be saved</text>
<line x1="645" y1="148" x2="645" y2="196" class="fx-lnb" marker-end="url(#aF2b)"/>
<text x="645" y="216" text-anchor="middle" class="fx-tbad" font-size="10.5">&#10005; caught before merge &#8212;</text>
<text x="645" y="230" text-anchor="middle" class="fx-tbad" font-size="10.5">even if gate 1 was skipped</text>
<path d="M110,148 V300 H468 V152" class="fx-ln fx-dash" marker-end="url(#aF2)"/>
<text x="289" y="272" text-anchor="middle" class="fx-t3">the bypass: the script skipped on an agent's machine</text>
<text x="289" y="288" text-anchor="middle" class="fx-t3">&#8212; still has to pass gate 2 to merge</text>
''',
    'Two enforcers, one honest bypass. The commit script refuses a '
    'rule-breaking change at the moment of saving; continuous integration '
    're-checks every rule across the whole history on the shared server. The '
    'dashed path is the designed-for failure: a skipped local check changes '
    'nothing, because merging is gated by the server, not by trust.',
    'A change flows through the commit script gate, is saved, pushed, and '
    're-checked by CI before merging; a bypass around the script is caught '
    'at CI.')

# ---- F3 · who does what: the connection chart --------------------------------
F3 = _fig(
    f'''viewBox="0 0 880 620">
<defs>{_mk('aF3')}{_mk('aF3a', 'fx-mka')}{_mk('aF3p', 'fx-mkp')}{_mk('aF3g', 'fx-mkg')}</defs>
<rect x="350" y="20" width="180" height="56" rx="10" class="fx-boxa"/>
<text x="440" y="43" text-anchor="middle" class="fx-ta" font-size="12.5">SPONSOR</text>
<text x="440" y="61" text-anchor="middle" class="fx-t3">the one human</text>
<rect x="330" y="170" width="220" height="76" rx="10" class="fx-boxs"/>
<text x="440" y="194" text-anchor="middle" class="fx-t">ORCHESTRATOR</text>
<text x="440" y="212" text-anchor="middle" class="fx-t3">sole spawner &#183; sole committer</text>
<text x="440" y="226" text-anchor="middle" class="fx-t3">relays word-for-word &#183; writes no substance</text>
<rect x="40" y="180" width="190" height="60" rx="10" class="fx-box"/>
<text x="135" y="203" text-anchor="middle" class="fx-t">SPEC LEAD</text>
<text x="135" y="221" text-anchor="middle" class="fx-t3">requirements &#183; decision records</text>
<rect x="660" y="180" width="190" height="60" rx="10" class="fx-boxp"/>
<text x="755" y="203" text-anchor="middle" class="fx-tp" font-size="12.5">AUDITOR</text>
<text x="755" y="221" text-anchor="middle" class="fx-t3">audits every seat</text>
<rect x="660" y="290" width="190" height="30" rx="8" class="fx-boxi"/>
<text x="755" y="309" text-anchor="middle" class="fx-t3">writes only its own reports</text>
<rect x="40" y="380" width="190" height="60" rx="10" class="fx-box"/>
<text x="135" y="403" text-anchor="middle" class="fx-t">IMPL LEAD</text>
<text x="135" y="421" text-anchor="middle" class="fx-t3">builds everything that ships</text>
<rect x="660" y="380" width="190" height="60" rx="10" class="fx-box"/>
<text x="755" y="403" text-anchor="middle" class="fx-t">VERIFICATION LEAD</text>
<text x="755" y="421" text-anchor="middle" class="fx-t3">tests &#183; models &#183; verdicts</text>
<rect x="40" y="520" width="190" height="56" rx="10" class="fx-ghost"/>
<text x="135" y="543" text-anchor="middle" class="fx-t2" font-weight="700">WORKERS &#215;N</text>
<text x="135" y="560" text-anchor="middle" class="fx-t3">one task each, then discarded</text>
<rect x="350" y="536" width="220" height="34" rx="8" class="fx-boxi"/>
<text x="460" y="557" text-anchor="middle" class="fx-t2">MAIN LINE &#8212; the official version</text>
<path d="M350,48 H135 V176" class="fx-lna" marker-end="url(#aF3a)" marker-start="url(#aF3a)"/>
<text x="145" y="130" class="fx-t3">vision &#8596; requirements</text>
<line x1="440" y1="166" x2="440" y2="80" class="fx-ln" marker-end="url(#aF3)"/>
<text x="432" y="130" text-anchor="end" class="fx-t3">escalations, by ladder</text>
<path d="M755,176 V44 H534" class="fx-lnp" marker-end="url(#aF3p)"/>
<text x="640" y="36" text-anchor="middle" class="fx-tp" font-size="10">critical findings, unedited</text>
<line x1="326" y1="210" x2="236" y2="210" class="fx-lnq fx-dash" marker-end="url(#aF3)"/>
<text x="281" y="200" text-anchor="middle" class="fx-t3">spawns</text>
<line x1="554" y1="210" x2="656" y2="210" class="fx-lnq fx-dash" marker-end="url(#aF3)"/>
<path d="M360,250 V330 H135 V376" class="fx-lnq fx-dash" marker-end="url(#aF3)"/>
<path d="M520,250 V330 H755 V376" class="fx-lnq fx-dash" marker-end="url(#aF3)"/>
<line x1="95" y1="244" x2="95" y2="376" class="fx-ln" marker-end="url(#aF3)"/>
<text x="88" y="330" text-anchor="end" class="fx-t3">frozen specs</text>
<path d="M175,244 V355 H710 V376" class="fx-lna" marker-end="url(#aF3a)"/>
<text x="442" y="347" text-anchor="middle" class="fx-ta" font-size="10.5">numbered requirements &#8212; tests derive from the promise, never the build</text>
<line x1="234" y1="410" x2="656" y2="410" class="fx-lnb fx-dash"/>
<text x="445" y="415" text-anchor="middle" class="fx-tbad" font-size="16">&#10005;</text>
<text x="445" y="436" text-anchor="middle" class="fx-tbad" font-size="10">the implementation never sources the tests that grade it</text>
<line x1="105" y1="444" x2="105" y2="516" class="fx-ln" marker-end="url(#aF3)"/>
<text x="97" y="484" text-anchor="end" class="fx-t3">packets</text>
<line x1="150" y1="516" x2="150" y2="444" class="fx-ln" marker-end="url(#aF3)"/>
<text x="158" y="470" class="fx-t3">returns,</text>
<text x="158" y="483" class="fx-t3">reviewed</text>
<path d="M215,444 V480 H460 V532" class="fx-ln" marker-end="url(#aF3)"/>
<text x="330" y="472" text-anchor="middle" class="fx-t3">accepted work</text>
<path d="M755,444 V553 H574" class="fx-lna" marker-end="url(#aF3a)"/>
<text x="762" y="500" class="fx-ta" font-size="10.5">sign-off gates</text>
<text x="762" y="514" class="fx-ta" font-size="10.5">every merge</text>
<path d="M660,196 V158 H210 V176" class="fx-lnp fx-dash" marker-end="url(#aF3p)"/>
<path d="M700,244 V286 M700,324 V376" class="fx-lnp fx-dash" marker-end="url(#aF3p)"/>
<text x="420" y="142" text-anchor="middle" class="fx-tp" font-size="10">re-runs every seat's recorded evidence &#8212; the orchestrator's too</text>
''',
    'The seats and the edges that matter. The orchestrator is the hub &#8212; it '
    'spawns, relays, and commits for everyone &#8212; but authors no substance. '
    'Tests flow from the specification lead to the verification lead (teal), '
    'never from the implementation (&#10005;). The auditor (purple) re-runs '
    'recorded evidence from every seat including its own spawner, can only '
    'write reports, and its critical findings reach the human unedited.',
    'Organization chart: sponsor above, orchestrator hub in the center, '
    'specification, implementation and verification leads plus workers and '
    'auditor, with labeled work, test, audit and escalation edges.')

# ---- F4 · the work-order lifecycle -------------------------------------------
F4 = _fig(
    f'''viewBox="0 0 880 300">
<defs>{_mk('aF4')}{_mk('aF4g', 'fx-mkg')}{_mk('aF4p', 'fx-mkp')}</defs>
<line x1="14" y1="92" x2="36" y2="92" class="fx-ln" marker-end="url(#aF4)"/>
<text x="14" y="50" class="fx-t3">a lead issues</text>
<rect x="40" y="60" width="150" height="64" rx="10" class="fx-box"/>
<text x="115" y="87" text-anchor="middle" class="fx-t">ISSUED</text>
<text x="115" y="105" text-anchor="middle" class="fx-t3">packet, with ID + spec</text>
<rect x="280" y="60" width="150" height="64" rx="10" class="fx-box"/>
<text x="355" y="87" text-anchor="middle" class="fx-t">RETURNED</text>
<text x="355" y="105" text-anchor="middle" class="fx-t3">exactly what it asks</text>
<path d="M555,52 L625,92 L555,132 L485,92 Z" class="fx-boxp"/>
<text x="555" y="88" text-anchor="middle" class="fx-tp" font-size="11.5">REVIEW</text>
<text x="555" y="104" text-anchor="middle" class="fx-t3">by the lead</text>
<rect x="690" y="60" width="160" height="64" rx="10" class="fx-boxs"/>
<text x="770" y="87" text-anchor="middle" class="fx-tg" font-size="12.5">ACCEPTED</text>
<text x="770" y="105" text-anchor="middle" class="fx-t3">continues toward merge</text>
<line x1="194" y1="92" x2="276" y2="92" class="fx-ln" marker-end="url(#aF4)"/>
<text x="235" y="50" text-anchor="middle" class="fx-t3">the seat executes</text>
<line x1="434" y1="92" x2="481" y2="92" class="fx-ln" marker-end="url(#aF4)"/>
<line x1="629" y1="92" x2="686" y2="92" class="fx-ln" marker-end="url(#aF4g)"/>
<text x="657" y="82" text-anchor="middle" class="fx-tg">&#10003;</text>
<path d="M555,136 V210 H115 V128" class="fx-lnp" marker-end="url(#aF4p)"/>
<text x="340" y="200" text-anchor="middle" class="fx-tp" font-size="10.5">&#10007; bounced &#8212; with a numbered defect list, back for another round</text>
<text x="340" y="246" text-anchor="middle" class="fx-t3">bounce #1, #2, #3 &#8230; every round stays on the record &#8212; the history is never tidied away</text>
''',
    'The work-order lifecycle. A packet travels issued &#8594; returned &#8594; '
    'reviewed; the reviewing seat either accepts it or bounces it back with a '
    'numbered defect list. The loop is the mechanism: rejection is routine, '
    'recorded, and repeatable &#8212; not an exception.',
    'State machine of a work order: issued, returned, reviewed, then accepted '
    'or bounced back with a numbered defect list; bounce history is preserved.')

# ---- F5 · the seeded-defect campaign -----------------------------------------
F5 = _fig(
    f'''viewBox="0 0 880 356">
<defs>{_mk('aF5')}{_mk('aF5a', 'fx-mka')}{_mk('aF5b', 'fx-mkb')}</defs>
<rect x="40" y="62" width="180" height="74" rx="10" class="fx-boxa"/>
<text x="130" y="86" text-anchor="middle" class="fx-ta" font-size="12">1 &#183; SEAL</text>
<text x="130" y="104" text-anchor="middle" class="fx-t3">verification lead freezes</text>
<text x="130" y="117" text-anchor="middle" class="fx-t3">its predictions &#8212; t&#8320;,</text>
<text x="130" y="130" text-anchor="middle" class="fx-t3">before any bug exists</text>
<rect x="260" y="62" width="180" height="74" rx="10" class="fx-box"/>
<text x="350" y="86" text-anchor="middle" class="fx-t" font-size="12">2 &#183; SEED</text>
<text x="350" y="104" text-anchor="middle" class="fx-t3">auditor plants known bugs</text>
<text x="350" y="117" text-anchor="middle" class="fx-t3">&#8212; blind to the seal,</text>
<text x="350" y="130" text-anchor="middle" class="fx-t3">in an isolated copy</text>
<rect x="480" y="62" width="180" height="74" rx="10" class="fx-box"/>
<text x="570" y="86" text-anchor="middle" class="fx-t" font-size="12">3 &#183; RUN</text>
<text x="570" y="104" text-anchor="middle" class="fx-t3">the test suite runs</text>
<text x="570" y="117" text-anchor="middle" class="fx-t3">against each planted bug</text>
<rect x="700" y="62" width="150" height="74" rx="10" class="fx-boxs"/>
<text x="775" y="86" text-anchor="middle" class="fx-t" font-size="12">4 &#183; SCORE</text>
<text x="775" y="104" text-anchor="middle" class="fx-t3">caught / missed,</text>
<text x="775" y="117" text-anchor="middle" class="fx-t3">graded against</text>
<text x="775" y="130" text-anchor="middle" class="fx-t3">the frozen record</text>
<line x1="224" y1="99" x2="256" y2="99" class="fx-ln" marker-end="url(#aF5)"/>
<line x1="444" y1="99" x2="476" y2="99" class="fx-ln" marker-end="url(#aF5)"/>
<line x1="664" y1="99" x2="696" y2="99" class="fx-ln" marker-end="url(#aF5)"/>
<line x1="240" y1="30" x2="240" y2="168" class="fx-lnp fx-dash"/>
<text x="252" y="152" text-anchor="middle" class="fx-tp" font-size="10" transform="rotate(-90 252 152)">one-way blind</text>
<path d="M775,58 C700,2 210,2 132,58" class="fx-lna fx-dash" marker-end="url(#aF5a)"/>
<text x="455" y="44" text-anchor="middle" class="fx-ta" font-size="10.5">scored against the t&#8320; seal &#8212; success cannot be redefined afterward</text>
<line x1="40" y1="252" x2="840" y2="252" class="fx-ln"/>
<text x="130" y="276" text-anchor="middle" class="fx-t3">the real product &#8212; untouched throughout</text>
<path d="M330,252 L460,212" class="fx-ln" marker-end="url(#aF5)"/>
<rect x="464" y="196" width="200" height="32" rx="8" class="fx-ghost"/>
<text x="564" y="216" text-anchor="middle" class="fx-t3">isolated copy of the work</text>
<path d="M668,212 L760,244" class="fx-lnb fx-dash"/>
<text x="722" y="218" text-anchor="middle" class="fx-tbad" font-size="14">&#10005;</text>
<text x="748" y="286" text-anchor="middle" class="fx-tbad" font-size="10">never merges back</text>
''',
    'A passing test suite isn&#8217;t trusted &#8212; it&#8217;s tested. The four '
    'acts run in a fixed order: predictions are sealed before any planted bug '
    'exists, the seeder works blind to the seal (one seat never sees the '
    'other&#8217;s work), the bugs live only in an isolated copy, and the score '
    'is read against the frozen t&#8320; record &#8212; so neither the predictor '
    'nor the scorer can move the goalposts.',
    'Timeline of a seeded-defect campaign: seal predictions, seed bugs blind, '
    'run tests on an isolated never-merged copy, score against the frozen '
    'seal.')

# ---- F6 · working habits: push early, crash safely ---------------------------
F6 = _fig(
    f'''viewBox="0 0 880 330">
<defs>{_mk('aF6')}{_mk('aF6a', 'fx-mka')}</defs>
<line x1="40" y1="120" x2="840" y2="120" class="fx-lnq"/>
<rect x="52" y="88" width="140" height="64" rx="10" class="fx-box"/>
<text x="122" y="112" text-anchor="middle" class="fx-t" font-size="11.5">PREFLIGHT</text>
<text x="122" y="129" text-anchor="middle" class="fx-t3">workspace as expected?</text>
<text x="122" y="143" text-anchor="middle" class="fx-t3">if not: stop + report</text>
<circle cx="300" cy="120" r="8" class="fx-boxa"/>
<text x="300" y="149" text-anchor="middle" class="fx-ta" font-size="10">push</text>
<circle cx="430" cy="120" r="8" class="fx-boxa"/>
<text x="430" y="149" text-anchor="middle" class="fx-ta" font-size="10">push</text>
<text x="560" y="128" text-anchor="middle" class="fx-tbad" font-size="22">&#10005;</text>
<text x="572" y="156" class="fx-tbad" font-size="10">session dies mid-edit</text>
<path d="M560,132 V210 H514" class="fx-lnb fx-dash" marker-end="url(#aF6)"/>
<rect x="290" y="192" width="220" height="52" rx="10" class="fx-boxi"/>
<text x="400" y="213" text-anchor="middle" class="fx-t3">the half-finished edit is preserved</text>
<text x="400" y="228" text-anchor="middle" class="fx-t3">as evidence &#8212; and removed from the workspace</text>
<rect x="680" y="60" width="168" height="64" rx="10" class="fx-box"/>
<text x="764" y="84" text-anchor="middle" class="fx-t" font-size="11.5">REPLACEMENT AGENT</text>
<text x="764" y="101" text-anchor="middle" class="fx-t3">starts over from the</text>
<text x="764" y="114" text-anchor="middle" class="fx-t3">committed record</text>
<path d="M436,111 C500,52 610,48 676,80" class="fx-lna" marker-end="url(#aF6a)"/>
<text x="548" y="26" text-anchor="middle" class="fx-ta" font-size="10.5">resumes from the last pushed commit &#8212;</text>
<text x="548" y="40" text-anchor="middle" class="fx-ta" font-size="10.5">never from the half-finished edit</text>
<text x="440" y="296" text-anchor="middle" class="fx-t3">work is pushed at every stopping point, because work that exists only inside one session dies with it</text>
''',
    'The crash law. A session checks its workspace before touching anything, '
    'pushes at every stopping point, and when it dies mid-edit the partial '
    'work is archived as evidence but never resumed &#8212; its author can&#8217;t '
    'be asked what it was about to do. The replacement starts from the last '
    'pushed commit, which is why pushing early is a survival rule, not a habit '
    'of tidiness.',
    'Session timeline with preflight check and push points; a crash preserves '
    'partial work as evidence while the replacement agent resumes from the '
    'last pushed commit.')

# ---- F7 · honesty grades: what weight a rule bears ---------------------------
F7 = _fig(
    f'''viewBox="0 0 880 372">
<defs>{_mk('aF7p', 'fx-mkp')}
<pattern id="hatchF7" width="7" height="7" patternTransform="rotate(45)" patternUnits="userSpaceOnUse">
<line x1="0" y1="0" x2="0" y2="7" class="fx-lnq" stroke-width="2"/></pattern></defs>
<rect x="60" y="52" width="760" height="28" rx="6" class="fx-boxs"/>
<text x="440" y="71" text-anchor="middle" class="fx-t" font-size="12">a rule of the constitution &#8212; how much weight can it bear?</text>
<rect x="100" y="80" width="110" height="196" class="fx-fillm" stroke="var(--rx)" stroke-width="1.6"/>
<rect x="290" y="80" width="110" height="180" fill="url(#hatchF7)" stroke="var(--ink-2)" stroke-width="1.4"/>
<text x="345" y="272" text-anchor="middle" class="fx-tp" font-size="9">residue &#8212; watched by a named seat</text>
<rect x="480" y="80" width="110" height="196" fill="none" class="fx-ln"/>
<rect x="495" y="164" width="80" height="26" rx="5" class="fx-boxi"/>
<text x="535" y="181" text-anchor="middle" class="fx-t3">2026-08-01</text>
<rect x="670" y="80" width="110" height="196" fill="none" class="fx-ghost"/>
<line x1="40" y1="276" x2="840" y2="276" class="fx-ln"/>
<text x="155" y="300" text-anchor="middle" class="fx-ta" font-size="10.5">MACHINE-CHECKED</text>
<text x="155" y="316" text-anchor="middle" class="fx-t3">a script refuses violations</text>
<text x="155" y="330" text-anchor="middle" class="fx-t3">&#8212; holds under pressure</text>
<text x="345" y="300" text-anchor="middle" class="fx-t2" font-weight="700" font-size="10.5">REVIEW-ENFORCED</text>
<text x="345" y="316" text-anchor="middle" class="fx-t3">a kept habit &#8212; holds only</text>
<text x="345" y="330" text-anchor="middle" class="fx-t3">while someone keeps it</text>
<text x="535" y="300" text-anchor="middle" class="fx-t2" font-weight="700" font-size="10.5">PERFORMED ONCE</text>
<text x="535" y="316" text-anchor="middle" class="fx-t3">it happened, on a date &#8212;</text>
<text x="535" y="330" text-anchor="middle" class="fx-t3">not a standing practice</text>
<text x="725" y="300" text-anchor="middle" class="fx-t2" font-weight="700" font-size="10.5">PLANNED</text>
<text x="725" y="316" text-anchor="middle" class="fx-t3">not built yet &#8212; bears</text>
<text x="725" y="330" text-anchor="middle" class="fx-t3">no weight at all</text>
<text x="440" y="360" text-anchor="middle" class="fx-tp" font-size="10.5">the auditor tests every grade by attempting exactly what it claims to block &#8212; an overstated grade is corrected</text>
''',
    'Every rule states its own honesty grade &#8212; how it is actually '
    'enforced, from a solid machine-checked column down to a dashed outline '
    'that exists only as intent. The grades are audited by attempted '
    'violation, and each rule also names its residue: the part enforcement '
    'can&#8217;t reach, with a seat assigned to watch that gap. A habit '
    'mistaken for a guarantee is how rules quietly die.',
    'Four columns of decreasing solidity bear a beam labeled as a rule of the '
    'constitution: machine-checked, review-enforced, performed once, and '
    'planned; a residue gap is marked at the review-enforced column.')

# ---- F8 · built to be copied: the export loop --------------------------------
F8 = _fig(
    f'''viewBox="0 0 880 320">
<defs>{_mk('aF8')}{_mk('aF8a', 'fx-mka')}</defs>
<rect x="60" y="20" width="344" height="34" rx="8" class="fx-boxi"/>
<text x="232" y="41" text-anchor="middle" class="fx-t3">failure museum &#8212; expensive mistakes rewritten as general lessons</text>
<line x1="145" y1="54" x2="145" y2="86" class="fx-ln" marker-end="url(#aF8)"/>
<rect x="60" y="90" width="170" height="110" rx="14" class="fx-box"/>
<text x="145" y="126" text-anchor="middle" class="fx-t">HANDBOOK</text>
<text x="145" y="148" text-anchor="middle" class="fx-t3">every rule paired with the</text>
<text x="145" y="161" text-anchor="middle" class="fx-t3">failure it exists to prevent</text>
<rect x="234" y="90" width="170" height="110" rx="14" class="fx-boxp"/>
<text x="319" y="126" text-anchor="middle" class="fx-tp" font-size="12.5">TOOLKIT</text>
<text x="319" y="148" text-anchor="middle" class="fx-t3">the runnable enforcement</text>
<text x="319" y="161" text-anchor="middle" class="fx-t3">scripts, ready to adopt</text>
<path d="M60,214 V224 H404 V214" class="fx-ln"/>
<text x="284" y="246" text-anchor="middle" class="fx-t2">the export unit &#8212; neither half works alone</text>
<line x1="408" y1="120" x2="446" y2="120" class="fx-lna" marker-end="url(#aF8a)"/>
<text x="427" y="108" text-anchor="middle" class="fx-t3">handed</text>
<text x="427" y="134" text-anchor="middle" class="fx-t3">whole</text>
<rect x="450" y="90" width="130" height="60" rx="10" class="fx-box"/>
<text x="515" y="114" text-anchor="middle" class="fx-t3">outsiders who have</text>
<text x="515" y="128" text-anchor="middle" class="fx-t3">never seen it</text>
<rect x="612" y="90" width="130" height="60" rx="10" class="fx-box"/>
<text x="677" y="114" text-anchor="middle" class="fx-t3">set a project up</text>
<text x="677" y="128" text-anchor="middle" class="fx-t3">from scratch</text>
<line x1="584" y1="120" x2="608" y2="120" class="fx-ln" marker-end="url(#aF8)"/>
<line x1="746" y1="120" x2="770" y2="120" class="fx-ln" marker-end="url(#aF8)"/>
<rect x="774" y="90" width="86" height="60" rx="10" class="fx-box"/>
<text x="817" y="114" text-anchor="middle" class="fx-t3">every stall</text>
<text x="817" y="128" text-anchor="middle" class="fx-t3">is logged</text>
<path d="M817,154 V262 H678" class="fx-lna" marker-end="url(#aF8a)"/>
<rect x="524" y="240" width="150" height="44" rx="10" class="fx-boxa"/>
<text x="599" y="258" text-anchor="middle" class="fx-ta" font-size="10.5">next revision</text>
<text x="599" y="274" text-anchor="middle" class="fx-t3">fixes what stalled</text>
<path d="M520,262 H145 V204" class="fx-lna" marker-end="url(#aF8a)"/>
<text x="330" y="278" text-anchor="middle" class="fx-t3">folds back into the unit</text>
''',
    'Built to be copied &#8212; and measured. The framework ships as a handbook '
    '(rules with their reasons) plus a runnable toolkit (the enforcement '
    'itself), because prose alone demonstrably doesn&#8217;t transfer. Whether '
    'it works is never assumed: strangers adopt it cold, every stall they hit '
    'is logged, and the next revision closes those gaps.',
    'The export unit of handbook plus toolkit is handed to outsiders who set '
    'up a project from scratch; stalls are logged and fold back into the next '
    'revision, with the failure museum feeding the handbook.')

# Placement map: heading text of a docs/FRAMEWORK.md section -> figures shown
# with it. '__intro__' is the pre-first-## chunk. build.py places the
# 'Who does what' figure after that section's intro paragraph (before the seat
# list); every other figure follows its section's full text.
FIGS = {
    '__intro__': [F1],
    'The rules and their enforcement': [F2],
    'Who does what': [F3],
    'The paper trail': [F4, F5],
    'Working habits': [F6],
    'Keeping itself honest': [F7, F8],
}
