# Figures for the FRAMEWORK page (site/public/framework.html). Consumed by
# site/build.py.
#
# The first set of figures was torn out (J-orchestrator-0289) for labelling
# where it should have encoded: boxes containing sentences, joined by arrows,
# with no quantity carried by position, size, area or colour. This set is built
# against one question per figure — WHAT IS THE QUANTITY, AND WHAT IS THE
# CHANNEL? — and each of the five uses a different channel, so the set cannot
# repeat itself:
#
#   F1 permission ......... cell presence / absence
#   F2 knowledge .......... position in time + an unbroken barrier
#   F3 coverage ........... horizontal extent
#   F4 protection ......... ink area
#   F5 work at risk ....... shaded interval area
#
# Every coordinate below is COMPUTED, never hand-placed: last round's
# collisions came from eyeballed offsets. Labels are <= 3 words; all
# explanation lives in the <figcaption>. Colours ride the site tokens so both
# themes work from one drawing.

# ---- shared palette + type ---------------------------------------------------

FRAMEWORK_CSS = """
:root { --fw-human:#b45309; --fw-gap:#b0433d; }
@media (prefers-color-scheme: dark) { :root { --fw-human:#e0a050; --fw-gap:#e07a74; } }
:root[data-theme="light"] { --fw-human:#b45309; --fw-gap:#b0433d; }
:root[data-theme="dark"]  { --fw-human:#e0a050; --fw-gap:#e07a74; }

.fig { margin:2.6rem 0 3rem; }
.fig svg { max-width:100%; height:auto; display:block; overflow:visible; }
.fig figcaption { font-size:.86rem; line-height:1.6; color:var(--ink-2);
  margin-top:1rem; max-width:74ch; }
.fig figcaption b { color:var(--ink); font-weight:600; }

/* type inside the drawings — nothing below 11.5px, headline labels larger */
.f-lab   { fill:var(--ink);   font:600 13px 'Plex Sans',system-ui,sans-serif; }
.f-lab2  { fill:var(--ink-2); font:500 12px 'Plex Sans',system-ui,sans-serif; }
.f-key   { fill:var(--ink-2); font:600 11.5px 'Plex Mono',monospace;
           letter-spacing:.08em; text-transform:uppercase; }
.f-keyr  { fill:var(--rx);    font:700 11.5px 'Plex Mono',monospace;
           letter-spacing:.1em; text-transform:uppercase; }
.f-keyh  { fill:var(--fw-human); font:700 11.5px 'Plex Mono',monospace;
           letter-spacing:.1em; text-transform:uppercase; }
.f-keyg  { fill:var(--fw-gap); font:700 11.5px 'Plex Mono',monospace;
           letter-spacing:.1em; text-transform:uppercase; }

/* marks */
.f-fill  { fill:var(--rx); }
.f-fillh { fill:var(--fw-human); }
.f-ring  { fill:none; stroke:var(--ink-2); stroke-width:1.7; }
.f-void  { fill:var(--ink-2); opacity:.16; }
.f-rule  { stroke:var(--line); stroke-width:1; fill:none; }
.f-rule2 { stroke:var(--ink-2); stroke-width:1.4; fill:none; }
.f-band  { fill:var(--chip); }
.f-panel { fill:var(--panel); stroke:var(--line); stroke-width:1.3; }
.f-arc   { fill:none; stroke:var(--rx); stroke-width:1.8; }
.f-gapln { stroke:var(--fw-gap); stroke-width:1.6; fill:none; }
.f-gapfl { fill:var(--fw-gap); }

/* F1 row hover — zero-JS enhancement: hovering a seat mutes the others */
.f-mx:hover .f-row       { opacity:.22; transition:opacity .12s; }
.f-mx .f-row:hover       { opacity:1; }
.f-mx .f-row             { transition:opacity .12s; }
.f-mx:hover .f-rowband   { opacity:0; }
.f-mx .f-row:hover .f-rowband { opacity:1; }
@media (prefers-reduced-motion: reduce) { .f-mx .f-row { transition:none; } }
"""


def _fig(body, caption, aria, vb):
    return (f'<figure class="fig"><svg role="img" aria-label="{aria}" '
            f'viewBox="0 0 {vb[0]} {vb[1]}">{body}</svg>'
            f'<figcaption>{caption}</figcaption></figure>')


# =============================================================================
# F1 — the permission matrix.  QUANTITY: permission.  CHANNEL: presence/absence.
# =============================================================================
# Rows are seats in lifecycle order; columns are powers in three groups. A
# filled disc = may AUTHOR this. A hollow ring = may handle, move or record it
# but not author it. An empty cell = forbidden, and the empty cells are the
# payload: the one-pager states five separate prohibitions in five separate
# paragraphs, and they are all one pattern once cross-tabulated.

_F1_GROUPS = [
    ('Constitutional', ['Ratify', 'Escalation rules', 'History lock', 'Approve exports']),
    ('The work',       ['Scope & vision', 'Specify', 'Build', 'Test', 'Repair', 'Sign off']),
    ('The machinery',  ['Spawn', 'Commit', 'Audit']),
]
#                        rat esc his exp | vis spe bld tst rep sgn | spw cmt aud
_F1_ROWS = [
    ('Sponsor',             'h', '####' '#.....' '...'),
    ('Orchestrator',        'a', '....' '000000' '##.'),
    ('Specification lead',  'a', '....' '.#..#.' '...'),
    ('Implementation lead', 'a', '....' '..#.#.' '...'),
    ('worker',              'w', '....' '..#.#.' '...'),
    ('Verification lead',   'a', '....' '...###' '...'),
    ('worker',              'w', '....' '...#..' '...'),
    ('Auditor',             'a', '....' '......' '..#'),
]


def _f1():
    LEFT, CW, GGAP, RH = 214, 41, 22, 33
    top = 200                                   # grid top
    ncol = sum(len(c) for _, c in _F1_GROUPS)
    # column centres, with a gap between groups
    xs, gx, x = [], [], LEFT
    for gi, (_, cols) in enumerate(_F1_GROUPS):
        gstart = x
        for _ in cols:
            xs.append(x + CW / 2)
            x += CW
        gx.append((gstart, x))
        if gi < len(_F1_GROUPS) - 1:
            x += GGAP
    W, H = x + 26, top + RH * len(_F1_ROWS) + 96
    o = []

    # group headers + their underline
    for (gname, cols), (a, b) in zip(_F1_GROUPS, gx):
        o.append(f'<text x="{(a + b) / 2:.0f}" y="26" text-anchor="middle" '
                 f'class="f-key">{gname}</text>')
        o.append(f'<line x1="{a}" y1="36" x2="{b}" y2="36" class="f-rule"/>')

    # rotated column labels
    for i, name in enumerate([c for _, cols in _F1_GROUPS for c in cols]):
        o.append(f'<text x="{xs[i]:.0f}" y="{top - 62}" class="f-lab2" '
                 f'transform="rotate(-54 {xs[i]:.0f} {top - 62})">{name}</text>')

    # the arc: tests derive from the specification and skip the implementation.
    # springs from Specify, arches OVER Build, lands on Test.
    i_spec = 5
    i_test = 7
    a1, a2 = xs[i_spec], xs[i_test]
    peak = top - 38
    o.append(f'<path d="M{a1:.0f} {top - 6} C {a1:.0f} {peak:.0f}, '
             f'{a2:.0f} {peak:.0f}, {a2:.0f} {top - 6}" class="f-arc"/>')
    o.append(f'<path d="M{a2 - 4:.0f} {top - 12} L {a2:.0f} {top - 4} '
             f'L {a2 + 4:.0f} {top - 12} Z" class="f-fill"/>')
    o.append(f'<text x="{(a1 + a2) / 2:.0f}" y="{top - 44}" text-anchor="middle" '
             f'class="f-keyr">tests derive here</text>')

    # rows
    for r, (name, kind, cells) in enumerate(_F1_ROWS):
        y = top + r * RH + RH / 2
        o.append(f'<g class="f-row">')
        o.append(f'<rect class="f-rowband" x="{LEFT - 200}" y="{y - RH / 2:.0f}" '
                 f'width="{W - LEFT + 194}" height="{RH}" fill="var(--chip)" opacity="0"/>')
        ind = 16 if kind == 'w' else 0
        cls = 'f-lab' if kind != 'w' else 'f-lab2'
        o.append(f'<text x="{LEFT - 18}" y="{y + 4:.0f}" text-anchor="end" '
                 f'class="{cls}">{name}</text>')
        if kind == 'w':                                    # worker tie to its lead
            o.append(f'<path d="M{LEFT - 78} {y - RH:.0f} V{y:.0f} h8" '
                     f'class="f-rule2" opacity=".45"/>')
        for c, ch in enumerate(cells):
            cx = xs[c]
            if ch == '#':
                k = 'f-fillh' if kind == 'h' else 'f-fill'
                rr = 7.5 if kind != 'w' else 5.5
                o.append(f'<circle cx="{cx:.0f}" cy="{y:.0f}" r="{rr}" class="{k}"/>')
            elif ch == '0':
                o.append(f'<circle cx="{cx:.0f}" cy="{y:.0f}" r="7" class="f-ring"/>')
            else:
                o.append(f'<circle cx="{cx:.0f}" cy="{y:.0f}" r="1.6" class="f-void"/>')
        o.append('</g>')
        if r < len(_F1_ROWS) - 1:
            o.append(f'<line x1="{LEFT - 8}" y1="{y + RH / 2:.0f}" x2="{W - 26}" '
                     f'y2="{y + RH / 2:.0f}" class="f-rule" opacity=".55"/>')

    # legend
    ly = top + RH * len(_F1_ROWS) + 44
    for dx, mark, txt in ((0, 'fill', 'may author'), (150, 'ring', 'may move, not author'),
                          (360, 'void', 'forbidden')):
        x0 = LEFT - 200 + dx
        if mark == 'fill':
            o.append(f'<circle cx="{x0 + 8}" cy="{ly - 4}" r="7.5" class="f-fill"/>')
        elif mark == 'ring':
            o.append(f'<circle cx="{x0 + 8}" cy="{ly - 4}" r="7" class="f-ring"/>')
        else:
            o.append(f'<circle cx="{x0 + 8}" cy="{ly - 4}" r="1.6" class="f-void"/>')
        o.append(f'<text x="{x0 + 24}" y="{ly}" class="f-lab2">{txt}</text>')
    o.append(f'<circle cx="{LEFT - 200 + 508}" cy="{ly - 4}" r="7.5" class="f-fillh"/>')
    o.append(f'<text x="{LEFT - 200 + 524}" y="{ly}" class="f-lab2">the human</text>')

    return _fig(''.join(o),
                'Every seat&rsquo;s powers, cross-tabulated. The one-pager states five separate '
                'prohibitions in five separate places, so no reader ever holds them at once; '
                'on a grid they are all in view together, and <b>every one of them is an empty '
                'cell.</b> The implementation row has no mark under <i>Test</i> &mdash; it '
                'never writes the tests that grade its own output &mdash; and the arc shows '
                'where those tests come from instead: they spring from the specification and '
                'arch <i>over</i> the build, never touching it. Every seat that authors '
                'something also repairs it &mdash; every seat but one. The auditor holds a single '
                'power and is the lone blank in the <i>Repair</i> column, because an auditor that '
                'repairs things has an incentive to find only what it can repair. The '
                'orchestrator spawns and commits, yet its whole run across the work group is '
                'hollow: total reach, zero authorship. And the human&rsquo;s row is filled at the '
                'frame and the vision, then blank across everything in between.',
                'Matrix of seats against powers. Filled discs mark authorship, hollow rings '
                'mark handling without authorship, and empty cells mark forbidden powers; the '
                'implementation row is empty under Test and the auditor row is empty under '
                'Repair.',
                (W, H))


# =============================================================================
# F2 — the seal.  QUANTITY: knowledge.  CHANNEL: position in time + a barrier.
# =============================================================================
# The campaign's honesty rests on an ordering and a blindness. The load-bearing
# fact is a NEGATIVE: when the prediction is sealed, the thing it predicts does
# not yet exist. Prose can only assert an absence; a chart can show it, by
# leaving the region genuinely empty.

def _f2():
    """Stripped to its two real ideas: the ordering, and the row-by-row scoring.

    The first draft was carrying a hatched band, a labelled 'blind' rule, a
    third time gate where nothing happened, and a product lane that was mostly
    dead space. A cold reader could decode none of the hatch and correctly
    called the labelled rule 'a wall drawn as a line labelled wall'. All of it
    is gone. What survives: an empty region that means what it looks like, four
    rows whose alignment does the comparing, and a gap between the lanes that
    nothing ever crosses.
    """
    W, H = 880, 372
    x0, x1 = 186, 838
    T = {'seal': 286, 'plant': 486, 'score': 742}
    ROWS = 4
    ry = [104 + i * 26 for i in range(ROWS)]          # the four defect classes
    low = [232 + i * 26 for i in range(ROWS)]         # same four, auditor's side
    held = [True, True, False, True]
    o = []

    # time gates
    for k, lab in (('seal', 'seal'), ('plant', 'plant'), ('score', 'score')):
        o.append(f'<line x1="{T[k]}" y1="66" x2="{T[k]}" y2="{low[-1] + 30}" '
                 f'class="f-rule" stroke-dasharray="3 5"/>')
        o.append(f'<text x="{T[k]}" y="56" text-anchor="middle" class="f-keyr">{lab}</text>')
    o.append(f'<path d="M{x0} 42 H{x1}" class="f-rule" opacity=".6"/>')
    o.append(f'<text x="{x1}" y="{low[-1] + 46}" text-anchor="end" class="f-key">time</text>')
    o.append(f'<path d="M{x0} {low[-1] + 40} H{x1 - 44}" class="f-rule2" opacity=".5"/>')
    o.append(f'<path d="M{x1 - 44} {low[-1] + 36} l 8 4 l -8 4 Z" fill="var(--ink-2)" opacity=".5"/>')

    o.append(f'<text x="{x0 - 14}" y="{ry[0] - 22}" text-anchor="end" class="f-lab">Verification</text>')
    o.append(f'<text x="{x0 - 14}" y="{ry[0] - 6}" text-anchor="end" class="f-lab">lead</text>')
    o.append(f'<text x="{x0 - 14}" y="{low[0] + 8}" text-anchor="end" class="f-lab">Auditor</text>')

    # the four sealed predictions, locked at t0 and carried to scoring
    o.append(f'<rect x="{T["seal"] - 34}" y="{ry[0] - 15}" width="30" '
             f'height="{ry[-1] - ry[0] + 30}" rx="4" fill="none" stroke="var(--rx)" stroke-width="1.6"/>')
    o.append(f'<path d="M{T["seal"] - 26} {ry[0] - 15} v-7 a7 7 0 0 1 14 0 v7" fill="none" '
             f'stroke="var(--rx)" stroke-width="1.6"/>')
    for i, yy in enumerate(ry):
        o.append(f'<rect x="{T["seal"] - 28}" y="{yy - 5}" width="18" height="10" rx="2" class="f-fill"/>')
        o.append(f'<line x1="{T["seal"] - 4}" y1="{yy}" x2="{T["score"] - 10}" y2="{yy}" '
                 f'stroke="var(--rx)" stroke-width="1.2" opacity=".5" stroke-dasharray="2 4"/>')

    # NOTHING in the auditor's half until the defects exist. No label: the
    # emptiness is the encoding, and a void that needs a caption is not working.
    for i, yy in enumerate(low):
        o.append(f'<path d="M{T["plant"]} {yy} H{T["score"]} C {T["score"] + 8} {yy}, '
                 f'{T["score"] + 8} {ry[i]}, {T["score"] + 16} {ry[i]}" fill="none" '
                 f'stroke="var(--fw-gap)" stroke-width="1.2" opacity=".5" stroke-dasharray="2 4"/>')
        o.append(f'<path d="M{T["plant"] + 4} {yy + 7} l 9 -15 l 9 15 Z" class="f-gapfl"/>')

    # the two halves are separated by a band nothing ever crosses
    mid = (ry[-1] + low[0]) / 2
    o.append(f'<rect x="{x0 - 8}" y="{mid - 11}" width="{T["score"] - x0 + 8}" height="22" '
             f'fill="var(--ink-2)" opacity=".13"/>')
    o.append(f'<line x1="{x0 - 8}" y1="{mid - 11}" x2="{T["score"]}" y2="{mid - 11}" class="f-rule2"/>')
    o.append(f'<line x1="{x0 - 8}" y1="{mid + 11}" x2="{T["score"]}" y2="{mid + 11}" class="f-rule2"/>')

    # scoring: each outcome lands in the row of the prediction it answers
    for i, yy in enumerate(ry):
        if held[i]:
            o.append(f'<circle cx="{T["score"] + 16}" cy="{yy}" r="6.5" class="f-fill"/>')
        else:
            o.append(f'<path d="M{T["score"] + 10} {yy - 6} l 12 12 M{T["score"] + 22} {yy - 6} '
                     f'l -12 12" stroke="var(--fw-gap)" stroke-width="2.6" fill="none"/>')
    o.append(f'<text x="{T["score"] + 16}" y="{ry[0] - 26}" text-anchor="middle" '
             f'class="f-key">prediction held / broke</text>')

    ly = low[-1] + 68
    o.append(f'<rect x="{x0 - 8}" y="{ly - 10}" width="18" height="10" rx="2" class="f-fill"/>')
    o.append(f'<text x="{x0 + 16}" y="{ly}" class="f-lab2">a sealed prediction</text>')
    o.append(f'<path d="M{x0 + 210} {ly + 1} l 9 -15 l 9 15 Z" class="f-gapfl"/>')
    o.append(f'<text x="{x0 + 236}" y="{ly}" class="f-lab2">a planted defect</text>')

    return _fig(''.join(o),
                'The campaign&rsquo;s honesty is an ordering, so it is drawn on a clock. '
                'Predictions are locked at the left, one per row. <b>Now look at the '
                'auditor&rsquo;s half before the middle gate: there is nothing in it.</b> When '
                'the verification lead sealed those predictions, not one of the defects it '
                'predicts existed yet &mdash; so they cannot have been tuned to what was '
                'planted, and no amount of good faith is being relied on to make that true. '
                'The band between the halves is what the verification line cannot see '
                'through: the defects are planted <i>secretly</i>, so no test can be quietly '
                'tuned to the thing it is about to be graded on. Each planted defect then '
                'rises at scoring to meet the prediction that anticipated it, and the verdict '
                'is read off that join. Note what counts as success here: a sealed prediction '
                'may be that a test <i>will miss</i> a whole class of bug &mdash; and when it '
                'duly misses, the prediction held. Three held; one broke, and the break is as '
                'legible as the rest.',
                'A timeline in two halves over three moments. Four sealed predictions are '
                'locked at the left; the auditor half is completely empty until defects are '
                'planted at the middle gate; a solid band separates the halves; and at the '
                'right each row ends in a hit or a cross.',
                (W, H))


# =============================================================================
# F3 — coverage.  QUANTITY: how much history a check covers.  CHANNEL: extent.
# =============================================================================
# "CI re-runs every rule across the entire history" is read as "CI also checks".
# The word 'entire' does no work without an image of a check whose scope is a
# growing interval rather than an event.

def _f3():
    W, H = 880, 348
    x0, N, SP = 116, 27, 25
    ticks = [x0 + i * SP for i in range(N)]
    spine = 150
    o = []
    skips = {6, 13, 21}
    pushes = [5, 11, 17, 22, 26]

    o.append(f'<text x="{x0 - 14}" y="{spine + 5}" text-anchor="end" class="f-lab">History</text>')
    o.append(f'<text x="{x0 - 14}" y="{spine - 34}" text-anchor="end" class="f-lab">Commit script</text>')
    o.append(f'<text x="{x0 - 14}" y="{spine - 18}" text-anchor="end" class="f-lab2">local, skippable</text>')
    o.append(f'<text x="{x0 - 14}" y="{spine + 42}" text-anchor="end" class="f-lab">CI</text>')
    o.append(f'<text x="{x0 - 14}" y="{spine + 58}" text-anchor="end" class="f-lab2">server, binding</text>')

    # the spine of commits, fading at the left so it reads as "so far", not a count
    o.append(f'<line x1="{ticks[0] - 3}" y1="{spine}" x2="{ticks[-1] + 16}" y2="{spine}" class="f-rule"/>')
    for tx in ticks:
        o.append(f'<rect x="{tx - 3}" y="{spine - 7}" width="6" height="14" rx="1.5" '
                 f'class="f-fill" opacity=".9"/>')

    # top track: one short segment per commit, covering only that commit — with holes
    for i, tx in enumerate(ticks):
        if i in skips:
            continue
        o.append(f'<rect x="{tx - 9}" y="{spine - 46}" width="18" height="9" rx="2" '
                 f'class="f-fill" opacity=".78"/>')
    for i in skips:
        tx = ticks[i]
        o.append(f'<rect x="{tx - 9}" y="{spine - 46}" width="18" height="9" rx="2" '
                 f'fill="none" stroke="var(--fw-gap)" stroke-width="1.4" stroke-dasharray="3 3"/>')
        o.append(f'<line x1="{tx}" y1="{spine - 34}" x2="{tx}" '
                 f'y2="{spine + 30 + len(pushes) * 17 + 4}" class="f-gapln" '
                 f'stroke-dasharray="2 4" opacity=".9"/>')

    # bottom track: every band starts at the first commit — length IS the claim
    for k, p in enumerate(pushes):
        by = spine + 30 + k * 17
        o.append(f'<rect x="{ticks[0] - 3}" y="{by}" width="{ticks[p] - ticks[0] + 11}" height="11" rx="3" '
                 f'fill="var(--tx)" opacity="{0.20 + k * 0.13:.2f}"/>')
        o.append(f'<line x1="{ticks[p] + 8}" y1="{by}" x2="{ticks[p] + 8}" y2="{by + 11}" '
                 f'stroke="var(--tx)" stroke-width="2"/>')
    ay = spine + 30 + len(pushes) * 17 + 20
    o.append(f'<path d="M{ticks[0] - 3} {ay - 12} V{ay - 4} H{ticks[0] + 40}" class="f-rule2" '
             f'opacity=".7"/>')
    o.append(f'<text x="{ticks[0] + 46}" y="{ay}" class="f-key">every run starts here</text>')

    # the merge gate hangs off the binding track, not the skippable one
    mx = ticks[-1] + 40
    o.append(f'<line x1="{mx}" y1="{spine + 12}" x2="{mx}" y2="{spine + 30 + len(pushes) * 17}" '
             f'class="f-rule2"/>')
    o.append(f'<text x="{mx + 10}" y="{spine + 44}" class="f-keyr">merge</text>')
    o.append(f'<path d="M{ticks[-1] + 16} {spine + 30 + (len(pushes) - 1) * 17 + 5} H{mx}" '
             f'stroke="var(--tx)" stroke-width="2" fill="none"/>')

    o.append(f'<text x="{ticks[min(skips)]}" y="{spine - 56}" text-anchor="middle" '
             f'class="f-keyg">skipped</text>')

    return _fig(''.join(o),
                'Why two enforcers, when one would do? Because they cover different amounts. '
                'The local script checks <b>one commit</b> &mdash; a short segment above its '
                'own tick &mdash; and an agent can skip it, which is what the dashed outlines '
                'are. Every server-side run instead starts again at the <b>first commit ever '
                'made</b>, so the bands below grow into a staircase whose length is the claim '
                '&ldquo;across the entire history&rdquo;. <b>Every dotted line dropping from a hole '
                'passes through band after band beneath it.</b> A skipped check is not an '
                'escape, it is a deferral. The merge gate hangs off the binding track, '
                'never the skippable one.',
                'A row of commits with short per-commit checks above it, three of them missing, '
                'and below it a staircase of bands each starting at the first commit, so the '
                'gaps above fall inside the bands below.',
                (W, H))


# =============================================================================
# F4 — what a grade buys.  QUANTITY: protection delivered.  CHANNEL: ink area.
# =============================================================================
# The four grades are a magnitude claim delivered as four nouns, and a reader
# files them as a taxonomy of equal boxes — the exact misreading the paragraph
# exists to prevent. Area fixes that, and it also shows the residue: a hole in
# a protection that is otherwise real.

_F4_ROWS = [
    ('machine-checked', 'solid',  0.00),
    ('review-enforced', 'stripe', 0.00),
    ('performed once',  'tick',   0.62),
    ('planned',         'empty',  0.86),
]


def _f4():
    W, H = 880, 372
    L, RW, RH2, GAP = 214, 560, 56, 24
    o = []
    o.append('<defs><pattern id="fwStripe" width="17" height="8" patternUnits="userSpaceOnUse">'
             '<rect x="0" y="0" width="7" height="8" fill="var(--rx)" opacity=".75"/></pattern>'
             '</defs>')
    for i, (name, kind, _unused) in enumerate(_F4_ROWS):
        y = 58 + i * (RH2 + GAP)
        nw, nh = 54, 26
        nx, ny = L + RW - 132, y + (RH2 - nh) / 2      # the residue sits INSIDE the ink
        ink_end = L + RW                                # where delivery stops
        # the rule's whole claim — an identical outer rectangle on every row
        o.append(f'<rect x="{L}" y="{y}" width="{RW}" height="{RH2}" fill="none" '
                 f'stroke="var(--line)" stroke-width="1.2"/>')
        # ink = protection actually delivered
        if kind == 'solid':
            o.append(f'<rect x="{L}" y="{y}" width="{RW}" height="{RH2}" fill="var(--rx)" opacity=".82"/>')
        elif kind == 'stripe':
            o.append(f'<rect x="{L}" y="{y}" width="{RW}" height="{RH2}" fill="url(#fwStripe)"/>')
        elif kind == 'tick':
            o.append(f'<rect x="{L}" y="{y}" width="15" height="{RH2}" fill="var(--rx)" opacity=".82"/>')
            ink_end = L + 15
        else:
            ink_end = L
        # residue: a hole punched through the delivered protection
        if kind in ('solid', 'stripe'):
            o.append(f'<rect x="{nx:.0f}" y="{ny:.0f}" width="{nw}" height="{nh}" fill="var(--bg)"/>')
            o.append(f'<rect x="{nx:.0f}" y="{ny:.0f}" width="{nw}" height="{nh}" fill="none" '
                     f'stroke="var(--fw-gap)" stroke-width="1.3" stroke-dasharray="3 3"/>')
            o.append(f'<circle cx="{nx + nw / 2:.0f}" cy="{ny + nh / 2:.0f}" r="4.5" class="f-gapfl"/>')
        # claimed but never delivered = exactly the ink's shortfall
        if ink_end < L + RW:
            o.append(f'<rect x="{ink_end}" y="{y}" width="{L + RW - ink_end}" height="{RH2}" '
                     f'fill="none" stroke="var(--fw-gap)" stroke-width="1.2" stroke-dasharray="6 5" '
                     f'opacity=".7"/>')
            o.append(f'<text x="{(ink_end + L + RW) / 2:.0f}" y="{y + RH2 / 2 + 4:.0f}" '
                     f'text-anchor="middle" class="f-keyg">claimed, not delivered</text>')
        o.append(f'<text x="{L - 18}" y="{y + RH2 / 2 + 4:.0f}" text-anchor="end" class="f-lab">{name}</text>')
    o.append(f'<text x="{L}" y="{40}" class="f-key">the rule&#8217;s whole claim</text>')
    o.append(f'<text x="{L + RW}" y="{40}" text-anchor="end" class="f-key" opacity=".8">'
             f'areas are schematic</text>')
    o.append(f'<line x1="{L}" y1="46" x2="{L + RW}" y2="46" class="f-rule"/>')
    ly = 58 + len(_F4_ROWS) * (RH2 + GAP) + 8
    o.append(f'<rect x="{L}" y="{ly - 9}" width="22" height="11" fill="var(--rx)" opacity=".82"/>')
    o.append(f'<text x="{L + 30}" y="{ly}" class="f-lab2">protection actually delivered</text>')
    o.append(f'<circle cx="{L + 268}" cy="{ly - 4}" r="4.5" class="f-gapfl"/>')
    o.append(f'<text x="{L + 280}" y="{ly}" class="f-lab2">residue &mdash; and the seat watching it</text>')

    return _fig(''.join(o),
                'Four grades, drawn as areas rather than named as categories &mdash; because '
                'the difference between them is a magnitude, and four equal boxes is exactly '
                'the misreading to avoid. Each outline is one rule&rsquo;s <i>whole claim</i>; '
                'the ink inside is what enforcement actually delivers. A machine-checked rule '
                'fills nearly all of it. A review-enforced rule is stripes &mdash; protection '
                'only where somebody looked, and the white between them is unwatched time. '
                '<b>Then the ink falls off a cliff:</b> <i>performed once</i> is not a bar at '
                'all but a mark at the left edge and then nothing, and <i>planned</i> is an '
                'empty outline &mdash; a claim with no protection under it at all. <b>And even '
                'the strongest row is not solid:</b> a genuinely machine-checked rule still '
                'names the part its enforcement cannot reach, punched here as a hole straight '
                'through the ink with the seat that watches that gap sitting in it. The lower '
                'two rows are almost all gap, which is why the grade is worth printing beside '
                'the rule.',
                'Four bars of identical outer size with steeply decreasing filled area: nearly '
                'solid, striped, a single narrow tick, and an empty outline. The two filled '
                'bars have a hole punched through them containing a marker.',
                (W, H))


# =============================================================================
# F5 — the only channel.  QUANTITY: work at risk.  CHANNEL: shaded interval.
# =============================================================================
# The habit "push at every stopping point" is justified by an interval the
# prose never names: the span between an agent's last write and its death. Give
# it an area and the rule stops being tidiness and becomes risk.

def _f5():
    """Two seats, four agents, one shared store. The subject is the shaded area.

    STRUCTURAL CONSTRAINT, and the reason the timings look staggered: no write
    stroke may cross another seat's agent bar. The first draft put the frequent
    writer on the upper rail, so all twelve of its strokes passed behind the
    lower seat's bar — which manufactured exactly the horizontal agent-to-agent
    connection the figure exists to deny. Fixed by construction: the sparse
    writer sits on top and its two strokes fall in the lower rail's gaps, so
    nothing crosses anything.
    """
    W, H = 880, 388
    x0, x1 = 176, 842
    railT, railB = 96, 168                    # crashing seat above, diligent below
    repo_top, repo_bot = 250, 328
    o = []

    def rail(ry, nm):                          # the rail IS the seat: it outlives every agent on it
        o.append(f'<line x1="{x0}" y1="{ry}" x2="{x1}" y2="{ry}" class="f-rule" '
                 f'stroke-dasharray="2 4"/>')
        o.append(f'<text x="{x0 - 14}" y="{ry + 4}" text-anchor="end" class="f-lab">{nm}</text>')
    rail(railT, 'Implementation')
    rail(railB, 'Specification')
    o.append(f'<text x="{x0 - 14}" y="{repo_top + 48}" text-anchor="end" class="f-lab">Repository</text>')

    commits = [250, 300, 340, 380, 420, 460, 500, 540, 660, 700, 760]
    lvl, path = repo_top + 58, [f'M{x0} {repo_bot}', f'L{x0} {repo_top + 58}']
    for cx in commits:
        path += [f'L{cx} {lvl:.1f}']
        lvl -= 4.6
        path += [f'L{cx} {lvl:.1f}']
    path += [f'L{x1} {lvl:.1f}', f'L{x1} {repo_bot} Z']
    o.append(f'<path d="{" ".join(path)}" fill="var(--rx)" opacity=".14" '
             f'stroke="var(--rx)" stroke-width="1.5"/>')

    strokes, bars = [], []                     # bars drawn last, so nothing sits on top of a seat

    def writes(ry, xs_):
        for wx in xs_:                         # work and journal entry, inseparable
            strokes.append(f'<path d="M{wx - 2} {ry + 11} V{repo_top}" class="f-rule2"/>')
            strokes.append(f'<path d="M{wx + 2} {ry + 11} V{repo_top}" class="f-rule2"/>')
            strokes.append(f'<circle cx="{wx}" cy="{repo_top}" r="3.6" class="f-fill"/>')

    def read(ry, rx_, hot=False):
        st = 'var(--rx)' if hot else 'var(--ink-2)'
        strokes.append(f'<path d="M{rx_} {repo_top} V{ry + 11}" stroke="{st}" stroke-width="1.5" '
                       f'fill="none" stroke-dasharray="3 3" opacity=".9"/>')
        strokes.append(f'<path d="M{rx_ - 4} {ry + 18} L{rx_} {ry + 10} L{rx_ + 4} {ry + 18} Z" '
                       f'fill="{st}" opacity=".9"/>')

    def bar(ry, ax, bx, crash=False):
        if crash:
            bars.append(f'<path d="M{ax} {ry - 11} H{bx - 12} l 8 5 l -8 6 l 8 6 l -8 5 H{ax} Z" '
                        f'fill="var(--panel)" stroke="var(--fw-gap)" stroke-width="2"/>')
        else:
            bars.append(f'<rect x="{ax}" y="{ry - 11}" width="{bx - ax}" height="22" rx="5" '
                        f'class="f-panel"/>')

    def exposure(ry, ax, bx, strong):
        o.append(f'<rect x="{ax}" y="{ry - 20}" width="{bx - ax}" height="40" '
                 f'fill="var(--fw-gap)" opacity="{".30" if strong else ".16"}"/>')

    # UPPER RAIL — one early write, a long unwritten stretch, then a crash.
    # Its two strokes (x=250 and x=760) fall in the lower rail's gaps by design.
    bar(railT, 224, 576, crash=True);  writes(railT, [250]);  read(railT, 236)
    exposure(railT, 250, 576, True)
    o.append(f'<rect x="{(250 + 576) / 2 - 86:.0f}" y="{railT - 44}" width="172" height="18" '
             f'fill="var(--bg)"/>')
    o.append(f'<text x="{(250 + 576) / 2:.0f}" y="{railT - 31}" text-anchor="middle" '
             f'class="f-keyg">lost if it ends here</text>')
    # the partial edit leaves the workspace and dead-ends: evidence, not a resume point.
    # routed BELOW the replacement's read so the two never touch.
    o.append(f'<path d="M576 {railT - 11} V{railT - 58} H636" class="f-gapln" stroke-dasharray="4 4"/>')
    o.append(f'<rect x="640" y="{railT - 70}" width="92" height="24" rx="5" fill="var(--bg)" '
             f'stroke="var(--fw-gap)" stroke-width="1.3" stroke-dasharray="4 3"/>')
    o.append(f'<text x="686" y="{railT - 54}" text-anchor="middle" class="f-lab2">evidence</text>')
    o.append(f'<line x1="736" y1="{railT - 68}" x2="736" y2="{railT - 48}" class="f-gapln" stroke-width="2.6"/>')
    # the replacement reads an EARLIER committed state — left of where the crash happened
    bar(railT, 620, 800);  writes(railT, [760]);  read(railT, 632, hot=True)
    exposure(railT, 760, 800, False)

    # LOWER RAIL — writes constantly, so almost nothing is ever only in-session
    bar(railB, 280, 560);  writes(railB, [300, 340, 380, 420, 460, 500, 540]);  read(railB, 290)
    exposure(railB, 540, 560, False)
    bar(railB, 644, 720);  writes(railB, [660, 700]);  read(railB, 652)
    exposure(railB, 700, 720, False)

    o.extend(strokes)
    o.extend(bars)

    ly = repo_bot + 34
    o.append(f'<path d="M{x0 - 2} {ly - 12} V{ly + 2} M{x0 + 2} {ly - 12} V{ly + 2}" class="f-rule2"/>')
    o.append(f'<text x="{x0 + 14}" y="{ly}" class="f-lab2">a write &mdash; work and journal, always paired</text>')
    o.append(f'<rect x="{x0 + 372}" y="{ly - 12}" width="20" height="13" fill="var(--fw-gap)" opacity=".30"/>')
    o.append(f'<text x="{x0 + 400}" y="{ly}" class="f-lab2">work that exists only inside a session</text>')

    return _fig(''.join(o),
                'Scan this figure for a line running <i>between</i> two agents. <b>There '
                'isn&rsquo;t one.</b> Every stroke is vertical &mdash; each agent writes down '
                'into the repository and reads back up out of it, and none of them touches '
                'another, which is what makes the record complete rather than merely diligent. '
                '(The orchestrator does the committing, under the authoring seat&rsquo;s name; '
                'a write here is that seat&rsquo;s work entering the record.) The rails are '
                'seats and run the full width, while the agents occupying them start, finish '
                'and vanish. The store&rsquo;s edge only ever steps up: a correction is a new '
                'step, never an erased one. <b>The red areas are the point.</b> They are the '
                'work that exists only inside a session &mdash; gone if it ends there. The '
                'agent below writes constantly and is barely exposed; the one above wrote once '
                'and then crashed, losing everything after that single write. Its partial work '
                'is kept as evidence outside the workspace and dead-ends there, because its '
                'author can no longer be asked what it was about to do &mdash; so its '
                'replacement starts by reading an <i>earlier</i> committed state instead.',
                'Two seat rails above a repository band. Agent bars connect to the band by '
                'vertical write and read strokes only, never to each other. Red shaded spans '
                'mark unwritten work: narrow for an agent that writes constantly, wide for one '
                'that crashed after a single early write.',
                (W, H))


# Placement: heading text of a docs/FRAMEWORK.md section -> figures shown with
# it. '__intro__' is the pre-first-## chunk. Working habits carries no figure of
# its own — F5, from the intro, serves it.
FIGS = {
    '__intro__':                     [_f5()],
    'The rules and their enforcement': [_f3()],
    'Who does what':                 [_f1()],
    'The paper trail':               [_f2()],
    'Keeping itself honest':         [_f4()],
}
