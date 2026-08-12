/* ============================================================================
   Every visual state is a pure function of one master time T, so scrubbing
   backwards is exact: history un-happens rather than being replayed.
   Journal entries accumulate from the same script that drives the animation —
   a write in a beat IS an entry in that seat's journal, which is the rule the
   whole framework is built on.
============================================================================ */
const $ = id => document.getElementById(id);
const esc = s => s.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');

const BEATS = [
 {ph:'ADOPT', t:0, d:5, bt:'An empty project',
  ax:'Nothing but a name and an intention. In this framework, whatever is not written down does not exist — and that is not a slogan, it is a consequence: the agents that will do the work forget everything between sessions and cannot be relied on to remember or self-report accurately. So before any engineering begins, an organization has to exist as files.',
  acts:[]},
 {ph:'ADOPT', t:5, d:8, bt:'The shell is adopted',
  ax:'The framework arrives whole and runnable — the enforcement scripts, the self-test that proves they still refuse what they claim to refuse, a constitution template, empty charters and journals, a roster, a program board, an escalation ladder. None of this is authored here. An adopter who had to rebuild the machinery from scratch would rebuild it slightly differently, and the guarantees would quietly stop being guarantees.',
  acts:[{k:'tok',f:'@left',to:'rp-scripts',kind:'kit',s:.05,e:.5},
        {k:'born',w:'g-shell',s:.3},
        {k:'born',w:'rp-const',s:.35},{k:'born',w:'rp-scripts',s:.4},
        {k:'born',w:'rp-selftest',s:.45},{k:'born',w:'rp-roster',s:.5},
        {k:'born',w:'rp-board',s:.55},{k:'born',w:'rp-gates',s:.6},{k:'born',w:'rp-ladder',s:.64},
        {k:'born',w:'rp-gate',s:.7},{k:'born',w:'rp-ci',s:.74},
        {k:'born',w:'g-seats',s:.78},
        {k:'sweep',s:.8,e:1}]},
 {ph:'ADOPT', t:13, d:6, bt:'The specifics filled in',
  ax:'A first session opens — the future orchestrator — and completes the template: which seats this project has, which files each seat may edit, how far a phase may run before the human hears about it. Note what just happened: the founding agent wrote the very rules that bind it, and granted itself its own permissions. Every commit it makes is paired with a journal entry from this moment on, including these.',
  acts:[{k:'spawn',w:'ag-orch',s:.05},
        {k:'tok',f:'ag-orch',to:'rp-const',kind:'write',s:.2,e:.6,
         ent:'Constitution completed from the shell template — seats, write scopes and escalation thresholds filled in for this project'},
        {k:'flash',w:'rp-const',s:.6,e:.85},
        {k:'tok',f:'ag-orch',to:'rp-seat-spec',kind:'write',s:.55,e:.92,
         ent:'Charters seeded for every seat the constitution names; journals opened empty'}]},
 {ph:'ADOPT', t:19, d:6, bt:'Ratification',
  ax:'Because the founding agent granted its own permissions, the organization cannot legitimize itself. The human reads the rules, the seats and the thresholds, and formally accepts them. This is the one act on the whole timeline that no agent can perform — and until it happens, nothing else should start.',
  acts:[{k:'tok',f:'rp-const',to:'ag-sponsor',kind:'read',s:.05,e:.4},
        {k:'tok',f:'ag-sponsor',to:'rp-const',kind:'gold',s:.5,e:.82},
        {k:'stamp',w:'st-rat',s:.85},{k:'flash',w:'rp-const',s:.85,e:1}]},
 {ph:'COMMISSION', t:25, d:6, bt:'The braindump',
  ax:'Now the sponsor says what they actually want: goals, priorities, the shape of the thing, what matters and what does not, the parts they are unsure about. Unstructured and incomplete is fine — this is raw material, not a specification. What matters is that it lands in the repository rather than staying in a conversation, so that months later a requirement can be traced back to the sentence that asked for it.',
  acts:[{k:'born',w:'g-inputs',s:.3},
        {k:'tok',f:'ag-sponsor',to:'rp-brief',kind:'gold',s:.1,e:.55},
        {k:'born',w:'rp-brief',s:.5},{k:'flash',w:'rp-brief',s:.55,e:.9}]},
 {ph:'COMMISSION', t:31, d:6, bt:'And the material to work from',
  ax:'With the braindump comes everything the project must build against but did not write: the standards it has to obey, reference designs and prior art, the constraints of the part it will run on. Handing these over at the start is what lets constraints become testable requirements instead of surprises discovered late. The organization now has a subject.',
  acts:[{k:'tok',f:'ag-sponsor',to:'rp-refs',kind:'gold',s:.05,e:.4},
        {k:'born',w:'rp-refs',s:.35},
        {k:'tok',f:'ag-sponsor',to:'rp-cons',kind:'gold',s:.4,e:.72},
        {k:'born',w:'rp-cons',s:.68}]},
 {ph:'SPECIFY', t:37, d:5, bt:'The specification lead is seated',
  ax:'The orchestrator spawns the specification lead — it is the only agent allowed to spawn another. The new session begins the way every session begins: by reading the files that define its seat, because it has no memory of any previous one. Its charter tells it what it owns, what it may edit, what “done” means, and when it must escalate.',
  acts:[{k:'spawn',w:'ag-spec',s:.15},
        {k:'tok',f:'rp-seat-spec',to:'ag-spec',kind:'read',s:.35,e:.8}]},
 {ph:'SPECIFY', t:42, d:7, bt:'From braindump to specification',
  ax:'The lead reads the sponsor’s dump and the reference material and turns them into something precise enough to build and to test against. Where the braindump is ambiguous it goes back to the human rather than guessing — the organization cannot know what to build until that is ironed out. The result is committed with a journal entry recording what it read and why it decided as it did.',
  acts:[{k:'tok',f:'rp-brief',to:'ag-spec',kind:'read',s:.03,e:.28},
        {k:'tok',f:'rp-refs',to:'ag-spec',kind:'read',s:.12,e:.36},
        {k:'tok',f:'ag-spec',to:'ag-sponsor',kind:'direct',s:.36,e:.55},
        {k:'tok',f:'ag-sponsor',to:'ag-spec',kind:'direct',s:.55,e:.72},
        {k:'born',w:'g-spec',s:.72},
        {k:'tok',f:'ag-spec',to:'rp-spec',kind:'write',s:.6,e:.92,
         ent:'Specification drafted from the braindump and the reference material; four ambiguities taken back to the sponsor before drafting'},
        {k:'born',w:'rp-spec',s:.88}]},
 {ph:'SPECIFY', t:49, d:8, bt:'Helpers, one task each',
  ax:'The lead does not write everything itself. It breaks the work into packets and the orchestrator spawns a worker per packet — each given only that packet’s context, returning exactly what it asks, then discarded. Their output is numbered, so that a test can later point at exactly what it verifies, and every return is reviewed by the lead before it counts.',
  acts:[{k:'spawn',w:'ag-ws1',s:.05},{k:'spawn',w:'ag-ws2',s:.1},
        {k:'tok',f:'ag-ws1',to:'rp-reqs',kind:'write',s:.25,e:.55,
         ent:'Requirements R1–R14 drafted from spec §2, one packet'},
        {k:'tok',f:'ag-ws2',to:'rp-reqs',kind:'write',s:.35,e:.65,
         ent:'Requirements R15–R28 drafted from spec §3, one packet'},
        {k:'born',w:'rp-reqs',s:.5},
        {k:'tok',f:'rp-reqs',to:'ag-spec',kind:'read',s:.66,e:.86},
        {k:'off',w:'ag-ws1',s:.9},{k:'off',w:'ag-ws2',s:.94}]},
 {ph:'SPECIFY', t:57, d:6, bt:'The spec goes back to the sponsor',
  ax:'The orchestrator carries the finished specification up, word for word, with any additions of its own explicitly marked. The sponsor checks it against the braindump it came from and signs. Scope and vision are theirs; the design decisions inside stay below, and are not theirs to make.',
  acts:[{k:'tok',f:'rp-spec',to:'ag-orch',kind:'read',s:.05,e:.32},
        {k:'tok',f:'ag-orch',to:'ag-sponsor',kind:'direct',s:.36,e:.62},
        {k:'tok',f:'ag-sponsor',to:'rp-spec',kind:'gold',s:.68,e:.9},
        {k:'stamp',w:'st-spec',s:.93}]},
 {ph:'BUILD & VERIFY', t:63, d:6, bt:'Work orders',
  ax:'The orchestrator decided that this part of the spec would be built by implementation and tested by verification, wrote the work orders, and passed them on. They are versioned files with an ID, an author, an addressee and a status — not messages that vanish. A packet can be issued, returned, accepted, or bounced, and every one of those states stays on the record.',
  acts:[{k:'born',w:'g-trail',s:.3},
        {k:'tok',f:'ag-orch',to:'rp-wo',kind:'write',s:.1,e:.5,
         ent:'WO-001 issued to implementation and WO-002 to verification, both scoped to spec §4'},
        {k:'born',w:'rp-wo',s:.45},{k:'flash',w:'rp-wo',s:.5,e:.8}]},
 {ph:'BUILD & VERIFY', t:69, d:6, bt:'Two leads, one wall between them',
  ax:'Implementation and verification are seated separately, and that separation is the point: the seat that builds a thing never writes the tests that grade it. Both read the same work orders and the same specification, and neither reads the other’s output to decide what to do.',
  acts:[{k:'spawn',w:'ag-impl',s:.1},{k:'spawn',w:'ag-verif',s:.18},
        {k:'tok',f:'rp-wo',to:'ag-impl',kind:'read',s:.35,e:.65},
        {k:'tok',f:'rp-wo',to:'ag-verif',kind:'read',s:.45,e:.75}]},
 {ph:'BUILD & VERIFY', t:75, d:7, bt:'Tests come from the promise',
  ax:'The verification lead derives its tests and its independent reference models from the specification — never from the implementation. That is what makes a passing test mean something: it checks what was promised, not what happened to get built. A test written by reading the code would agree with the code by construction.',
  acts:[{k:'tok',f:'rp-spec',to:'ag-verif',kind:'read',s:.03,e:.3},
        {k:'born',w:'g-ver',s:.45},
        {k:'tok',f:'ag-verif',to:'rp-tb',kind:'write',s:.35,e:.65,
         ent:'Testbenches derived from requirements R1–R28; no implementation source read'},
        {k:'born',w:'rp-tb',s:.6},
        {k:'tok',f:'ag-verif',to:'rp-model',kind:'write',s:.55,e:.85,
         ent:'Independent reference model written from the spec as a second opinion'},
        {k:'born',w:'rp-model',s:.8}]},
 {ph:'BUILD & VERIFY', t:82, d:8, bt:'Parallel build',
  ax:'Workers build in parallel under their leads, each on one packet. Watch the journal chips: every landing pairs the work with an entry recording its trigger, what the agent read, its reasoning and its evidence. The commit script enforces that pairing — an agent cannot save work without it — so the record is complete by construction rather than by diligence.',
  acts:[{k:'spawn',w:'ag-wi1',s:.03},{k:'spawn',w:'ag-wi2',s:.08},{k:'spawn',w:'ag-wv1',s:.13},
        {k:'born',w:'g-prod',s:.3},
        {k:'tok',f:'ag-wi1',to:'rp-rtl',kind:'write',s:.2,e:.5,
         ent:'Module built to spec §4.1; expected behaviour cited per requirement'},
        {k:'born',w:'rp-rtl',s:.45},
        {k:'tok',f:'ag-wi2',to:'rp-rtl',kind:'write',s:.35,e:.62,
         ent:'Module built to spec §4.2'},
        {k:'tok',f:'ag-wv1',to:'rp-tb',kind:'write',s:.5,e:.78,
         ent:'Bench written for requirements R7–R12, derived from the spec text alone'},
        {k:'sweep',s:.8,e:1}]},
 {ph:'BUILD & VERIFY', t:90, d:5, bt:'Refused at the gate',
  ax:'One change breaks a rule of the constitution — it edits a file outside the agent’s write scope. The commit script refuses it outright: it cannot even be saved, let alone merged, and no human had to notice. Note that no journal entry appears for it either. A refused commit leaves no trace in the record because it never became part of the record.',
  acts:[{k:'tok',f:'ag-wi2',to:'rp-gate',kind:'refused',s:.15,e:.85}]},
 {ph:'BUILD & VERIFY', t:95, d:7, bt:'Bounced, with a numbered list',
  ax:'A worker’s return falls short of what its packet asked for. The lead bounces it back with a numbered defect list, and the next round answers it item by item. Both the bounce and the answer stay on the record — rejection here is a routine, recorded state of a work order, not a failure to be tidied away.',
  acts:[{k:'tok',f:'ag-wi2',to:'rp-wo',kind:'write',s:.05,e:.3,
         ent:'Return submitted for WO-001, second packet'},
        {k:'tok',f:'rp-wo',to:'ag-impl',kind:'read',s:.32,e:.52},
        {k:'tok',f:'ag-impl',to:'rp-wo',kind:'write',s:.55,e:.75,
         ent:'WO-001 return BOUNCED with a six-item numbered defect list; grounds recorded per item'},
        {k:'tok',f:'rp-wo',to:'ag-wi2',kind:'read',s:.78,e:.95},
        {k:'flash',w:'rp-wo',s:.5,e:.9}]},
 {ph:'BUILD & VERIFY', t:102, d:5, bt:'A fork in the design',
  ax:'A non-obvious choice comes up — two approaches, neither clearly better. A decision record captures the decision, the alternatives considered, and why each one lost, so that a rejected idea cannot come back six months later looking fresh. One seat proposes it; a different seat accepts it.',
  acts:[{k:'tok',f:'ag-spec',to:'rp-dr',kind:'write',s:.15,e:.6,
         ent:'Decision record: interface framing, three alternatives weighed, grounds for each rejection'},
        {k:'born',w:'rp-dr',s:.55}]},
 {ph:'BUILD & VERIFY', t:107, d:6, bt:'A finding',
  ax:'Verification files a finding against the build, graded critical, major, minor or note. Any seat may file one, even against itself. It closes only when repaired, or ruled on with written grounds by whoever owns the thing it is about — and “whoever owns it” is exactly the seat that can fix it. Being ignored is not one of the exits.',
  acts:[{k:'tok',f:'ag-verif',to:'rp-find',kind:'write',s:.05,e:.35,
         ent:'Finding filed: MAJOR, edge-case handling contradicts requirement R19'},
        {k:'born',w:'rp-find',s:.3},
        {k:'tok',f:'rp-find',to:'ag-impl',kind:'read',s:.4,e:.6},
        {k:'tok',f:'ag-impl',to:'rp-rtl',kind:'write',s:.65,e:.9,
         ent:'Finding repaired; the failing case now passes, evidence attached'},
        {k:'flash',w:'rp-find',s:.85,e:1}]},
 {ph:'AUDIT', t:113, d:7, bt:'The auditor re-runs the record',
  ax:'The auditor audits the agents, not the electrons. It reads what other seats recorded as evidence and re-executes those commands to check the results actually come out as claimed. It audits every seat — including the orchestrator that spawned it — and it may write only its own reports, so it cannot fix anything it finds. That restriction is deliberate: an auditor that repairs things has an incentive to find only what it can repair.',
  acts:[{k:'spawn',w:'ag-audit',s:.05},
        {k:'tok',f:'jr-impl',to:'ag-audit',kind:'read',s:.2,e:.45},
        {k:'tok',f:'jr-verif',to:'ag-audit',kind:'read',s:.35,e:.6},
        {k:'tok',f:'ag-audit',to:'rp-aud',kind:'alert',s:.65,e:.9,
         ent:'Audit report: twelve recorded commands re-executed, two did not reproduce as claimed'},
        {k:'born',w:'rp-aud',s:.85}]},
 {ph:'AUDIT', t:120, d:5, bt:'The seal',
  ax:'A passing test suite is not trusted here — it is tested. Before any planted bug exists, the verification lead writes down and freezes which kinds of defect its tests will catch and which they will miss. Predicting the misses matters as much as predicting the catches: the seal is a claim about the suite’s real shape, and freezing it first is what stops success from being redefined afterwards.',
  acts:[{k:'born',w:'g-mem',s:.3},
        {k:'tok',f:'ag-verif',to:'rp-camp',kind:'write',s:.1,e:.6,
         ent:'Campaign predictions SEALED before any defect exists: nine classes, six predicted caught, three predicted missed'},
        {k:'born',w:'rp-camp',s:.55},{k:'stamp',w:'st-seal',s:.7},
        {k:'flash',w:'rp-camp',s:.6,e:1}]},
 {ph:'AUDIT', t:125, d:8, bt:'Bugs, planted blind',
  ax:'Only now does the auditor plant known defects — secretly, and in an isolated copy of the work, never in the real product. It plants them without seeing what the seal predicts, and the seal was frozen before these bugs existed. Neither side can have tuned itself to the other.',
  acts:[{k:'born',w:'x-iso',s:.15},
        {k:'tok',f:'ag-audit',to:'x-iso',kind:'bug',s:.3,e:.55},{k:'bug',w:'bug1',s:.55},
        {k:'tok',f:'ag-audit',to:'x-iso',kind:'bug',s:.5,e:.72},{k:'bug',w:'bug2',s:.72},
        {k:'tok',f:'ag-audit',to:'x-iso',kind:'bug',s:.68,e:.9},{k:'bug',w:'bug3',s:.9}]},
 {ph:'AUDIT', t:133, d:7, bt:'Scored against the frozen record',
  ax:'The suite runs against every planted defect and each outcome is graded against the sealed prediction — caught where a catch was predicted, missed where a miss was predicted. A missed bug that the seal called is not a failure of the campaign; an unpredicted miss is. Then the copy is discarded. It never merges back, because it was only ever a target.',
  acts:[{k:'flash',w:'x-iso',s:.05,e:.4},
        {k:'tok',f:'x-iso',to:'rp-camp',kind:'read',s:.45,e:.7},
        {k:'flash',w:'rp-camp',s:.7,e:.95},
        {k:'gone',w:'x-iso',s:.97}]},
 {ph:'AUDIT', t:140, d:5, bt:'Straight to the human',
  ax:'One finding is critical. It reaches the sponsor unedited — no seat sits between the auditor and the human, not even the orchestrator that spawned it and that relays everything else. The escalation ladder decides which classes of problem travel this way, so it is a rule rather than a judgement call made in the moment.',
  acts:[{k:'tok',f:'ag-audit',to:'ag-sponsor',kind:'alert',s:.15,e:.75}]},
 {ph:'GATE', t:145, d:5, bt:'Sign-off',
  ax:'The verification lead issues its verdict on the finished work, with the exact commands to reproduce it — a claim anyone can re-run rather than a statement anyone must believe. Failing verdicts are not deleted when they are fixed; they stay on the record beside the fix.',
  acts:[{k:'tok',f:'ag-verif',to:'rp-so',kind:'write',s:.1,e:.55,
         ent:'Sign-off issued: PASS on all rows, with reproduction commands and the campaign score attached'},
        {k:'born',w:'rp-so',s:.5},{k:'stamp',w:'st-so',s:.7},
        {k:'flash',w:'rp-so',s:.55,e:1}]},
 {ph:'GATE', t:150, d:7, bt:'The harvest',
  ax:'Before the gate can close, every seat re-reads its own journal and mines it for lessons — and the lessons are rewritten to hold in any project, not just this one, or they are worth nothing to the next adopter. “Found nothing” is an acceptable answer, but it must be said explicitly and recorded; it can never be skipped silently.',
  acts:[{k:'tok',f:'jr-spec',to:'ag-spec',kind:'read',s:.05,e:.3},
        {k:'tok',f:'jr-impl',to:'ag-impl',kind:'read',s:.15,e:.4},
        {k:'tok',f:'jr-verif',to:'ag-verif',kind:'read',s:.25,e:.5},
        {k:'tok',f:'ag-impl',to:'rp-museum',kind:'write',s:.55,e:.8,
         ent:'Harvest: two lessons generalized to the failure museum; one seat reported “found nothing”'},
        {k:'born',w:'rp-museum',s:.75},{k:'flash',w:'rp-museum',s:.8,e:1}]},
 {ph:'GATE', t:157, d:7, bt:'The gate',
  ax:'A stage closes on a committed checklist that must be fully signed before the project advances. Every signature points at an entry in the signer’s own journal saying it signs — a claim you can follow to its evidence, not a checkbox someone ticked. The auditor countersigns, and the sponsor signs last.',
  acts:[{k:'tok',f:'ag-impl',to:'rp-gates',kind:'write',s:.05,e:.3,
         ent:'Gate row signed: implementation, citing the sign-off and the repaired finding'},
        {k:'tok',f:'ag-verif',to:'rp-gates',kind:'write',s:.2,e:.45,
         ent:'Gate row signed: verification, citing the campaign score against the seal'},
        {k:'tok',f:'ag-audit',to:'rp-gates',kind:'alert',s:.35,e:.6,
         ent:'Gate countersigned by the auditor; one caveat recorded rather than waived'},
        {k:'tok',f:'ag-sponsor',to:'rp-gates',kind:'gold',s:.6,e:.85},
        {k:'stamp',w:'st-gate',s:.9},{k:'flash',w:'rp-gates',s:.85,e:1}]},
 {ph:'GATE', t:164, d:7, bt:'The agents leave; the record stays',
  ax:'Sessions end and their memory dies with them — but nothing lived only in a session. Every decision, every bounce, every refuted claim and every lesson is a file on the right, and a brand-new agent could reconstruct the entire program state from those files alone. Scrub back to the start and watch it build: that accumulation is the framework’s only real output.',
  acts:[{k:'off',w:'ag-wi1',s:.15},{k:'off',w:'ag-wi2',s:.2},{k:'off',w:'ag-wv1',s:.25},
        {k:'off',w:'ag-spec',s:.35},{k:'off',w:'ag-impl',s:.4},{k:'off',w:'ag-verif',s:.45},
        {k:'off',w:'ag-audit',s:.5},{k:'off',w:'ag-orch',s:.65},
        {k:'sweep',s:.7,e:1}]},
];
const TOTAL = BEATS[BEATS.length-1].t + BEATS[BEATS.length-1].d;
const LOAD_AT = 145;

const JMAP = { 'ag-orch':'jr-orch','ag-spec':'jr-spec','ag-impl':'jr-impl',
  'ag-verif':'jr-verif','ag-audit':'jr-audit','ag-ws1':'jr-workers',
  'ag-ws2':'jr-workers','ag-wi1':'jr-workers','ag-wi2':'jr-workers','ag-wv1':'jr-workers' };
const WHO = { 'ag-ws1':'spec worker','ag-ws2':'spec worker','ag-wi1':'build worker',
  'ag-wi2':'build worker','ag-wv1':'test worker' };

const births = {}, gones = {}, stamps = [], occ = {}, bugs = {}, jentries = {};
for (const b of BEATS) for (const a of b.acts) {
  const at = b.t + (a.s ?? .5) * b.d;
  if (a.k === 'born') births[a.w] = at;
  if (a.k === 'gone') gones[a.w] = at;
  if (a.k === 'stamp') stamps.push([a.w, at]);
  if (a.k === 'bug') bugs[a.w] = at;
  if (a.k === 'spawn') (occ[a.w] ??= []).push([at, Infinity]);
  if (a.k === 'off') { const iv = occ[a.w]; if (iv) iv[iv.length-1][1] = at; }
  if (a.k === 'tok' && a.ent) {
    const j = JMAP[a.f];
    if (j) (jentries[j] ??= []).push({ t: b.t + (a.e ?? 1) * b.d, title: a.ent, by: WHO[a.f] });
  }
}
for (const j in jentries) jentries[j].sort((x,y) => x.t - y.t);
const SLOT_BORN = births['g-seats'] ?? 0;

const KINDS = {
  write:  {c:'var(--rx)',    shape:'pair', gate:true},
  read:   {c:'var(--rx)',    shape:'ringd'},
  direct: {c:'var(--ink-2)', shape:'ring'},
  gold:   {c:'var(--human)', shape:'sq',   gate:true},
  refused:{c:'var(--bad)',   shape:'pair'},
  alert:  {c:'var(--tx)',    shape:'sq',   gate:true},
  bug:    {c:'var(--bad)',   shape:'tri'},
  kit:    {c:'var(--rx)',    shape:'kit'},
};

const stage = $('stage'), fx = $('fx');
function center(id) {
  if (id === '@left') { const s = stage.getBoundingClientRect();
    return { x: -46, y: s.height * 0.42 }; }
  const el = $(id); if (!el) return null;
  const r = el.getBoundingClientRect(), s = stage.getBoundingClientRect();
  return { x: r.left - s.left + r.width/2, y: r.top - s.top + r.height/2 };
}
const lerp = (a,b,p) => a+(b-a)*p;
const ease = p => p<.5 ? 2*p*p : 1-Math.pow(-2*p+2,2)/2;
function arcPos(A,B,p){
  const lift = Math.min(44, Math.hypot(B.x-A.x, B.y-A.y)*.17);
  return { x:lerp(A.x,B.x,p), y:lerp(A.y,B.y,p) - Math.sin(p*Math.PI)*lift };
}
function tokPos(a, p) {
  const A = center(a.f), B = center(a.to); if (!A||!B) return null;
  if (a.kind === 'refused') {
    const G = center('rp-gate'); if (!G) return null;
    return p < .5 ? arcPos(A, G, ease(p*2)) : arcPos(G, A, ease((p-.5)*2));
  }
  if (KINDS[a.kind].gate && a.f.startsWith('ag-') && (a.to.startsWith('rp-')||a.to.startsWith('jr-'))) {
    const G = center('rp-gate'); if (!G) return null;
    return p < .45 ? arcPos(A, G, ease(p/.45)) : arcPos(G, B, ease((p-.45)/.55));
  }
  return arcPos(A, B, ease(p));
}
function tokSvg(kind) {
  const kd = KINDS[kind], ns = 'http://www.w3.org/2000/svg';
  const g = document.createElementNS(ns,'g');
  const mk = (n,at)=>{ const e=document.createElementNS(ns,n);
    for (const k in at) e.setAttribute(k,at[k]); g.appendChild(e); return e; };
  if (kd.shape==='pair'){ mk('rect',{x:-8,y:-5,width:7,height:10,rx:2,fill:kd.c});
                          mk('rect',{x:1,y:-5,width:7,height:10,rx:2,fill:kd.c,opacity:.62}); }
  else if (kd.shape==='sq') mk('rect',{x:-5.5,y:-5.5,width:11,height:11,rx:2.5,fill:kd.c});
  else if (kd.shape==='tri') mk('path',{d:'M0,-6 L6,5 L-6,5 Z',fill:kd.c});
  else if (kd.shape==='ringd') mk('circle',{r:5.5,fill:'none',stroke:kd.c,'stroke-width':2,'stroke-dasharray':'3 3'});
  else if (kd.shape==='kit'){ mk('rect',{x:-17,y:-11,width:34,height:22,rx:4,fill:'none',stroke:kd.c,'stroke-width':2});
    mk('rect',{x:-12,y:-6,width:8,height:5,rx:1,fill:kd.c}); mk('rect',{x:-12,y:1,width:8,height:5,rx:1,fill:kd.c});
    mk('rect',{x:-1,y:-6,width:12,height:5,rx:1,fill:kd.c,opacity:.6}); mk('rect',{x:-1,y:1,width:12,height:5,rx:1,fill:kd.c,opacity:.6}); }
  else mk('circle',{r:5.5,fill:'none',stroke:kd.c,'stroke-width':2});
  return g;
}

/* ---- reporting lines: leads feed a spine up to the orchestrator, the
   orchestrator reports to the human, live workers point at their lead ---- */
const CREW = [['ag-spec','ag-ws1','ag-ws2'],['ag-impl','ag-wi1','ag-wi2'],
              ['ag-verif','ag-wv1'],['ag-audit']];
function drawWires() {
  const svg = $('wires'); if (!svg) return;
  const panel = svg.parentElement, pr = panel.getBoundingClientRect();
  svg.setAttribute('width', pr.width); svg.setAttribute('height', pr.height);
  svg.setAttribute('viewBox', `0 0 ${pr.width} ${pr.height}`);
  const R = el => { const r = el.getBoundingClientRect();
    return { l:r.left-pr.left, r:r.right-pr.left, t:r.top-pr.top, b:r.bottom-pr.top,
             cx:r.left-pr.left+r.width/2, cy:r.top-pr.top+r.height/2 }; };
  const live = id => $(id) && $(id).classList.contains('live');
  const out = [`<defs>
    <marker id="ah" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0,1.5 L9,5 L0,8.5 z" fill="var(--ink-2)"/></marker>
    <marker id="ahl" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0,1.5 L9,5 L0,8.5 z" fill="var(--rx)"/></marker></defs>`];
  const P = (d, hot, head=true) => out.push(
    `<path d="${d}" fill="none" stroke="${hot?'var(--rx)':'var(--line)'}" stroke-width="${hot?1.8:1.3}"`
    + `${hot?'':' stroke-dasharray="3 3"'}${head?` marker-end="url(#${hot?'ahl':'ah'})"`:''} opacity="${hot?.95:.6}"/>`);

  const sp = R($('ag-sponsor')), or = R($('ag-orch'));
  P(`M${or.cx} ${or.t-2} V${sp.b+4}`, live('ag-orch'));           // orchestrator → the human

  const first = $(CREW[0][0]); if (!first) { svg.innerHTML = out.join(''); return; }
  const spineX = R(first).l - 15, collectY = or.b + 11;
  let lastCy = collectY;
  for (const [lid] of CREW) { const el = $(lid); if (el) lastCy = Math.max(lastCy, R(el).cy); }
  P(`M${spineX} ${collectY} V${lastCy}`, false, false);            // the shared spine
  P(`M${spineX} ${collectY+2} V${collectY-2} H${or.cx} V${or.b+3}`,
    CREW.some(([l]) => live(l)));                                  // spine → orchestrator
  for (const [lid, ...wids] of CREW) {
    const el = $(lid); if (!el) continue;
    const L = R(el), hot = live(lid);
    P(`M${L.l-4} ${L.cy} H${spineX}`, hot);                        // lead → spine
    for (const wid of wids) {
      if (!live(wid)) continue;
      const W = R($(wid));
      P(`M${W.l-3} ${W.cy} H${L.r+4}`, true);                      // worker → its lead
    }
  }
  svg.innerHTML = out.join('');
}

let T = LOAD_AT, playing = false, speed = 1, lastFrame = 0, openCard = null;
const liveToks = new Map();

function render() {
  for (const w in births) {
    const el = $(w); if (!el) continue;
    const dead = gones[w] !== undefined && T >= gones[w];
    el.classList.toggle('unborn', T < births[w] || dead);
  }
  for (const [w, at] of stamps) { const el = $(w); if (el) el.style.opacity = T >= at ? 1 : 0; }
  for (const w in bugs) { const el = $(w); if (el) el.style.opacity = T >= bugs[w] ? 1 : 0; }

  document.querySelectorAll('.agnode').forEach(el => {
    if (el.id === 'ag-sponsor') return;
    const iv = occ[el.id] || [];
    const on = iv.some(([a,b]) => T >= a && T < b);
    el.classList.toggle('live', on);
    el.classList.toggle('ghost', !on);
    el.classList.toggle('unborn', T < SLOT_BORN && !on);
  });
  $('sessions').style.opacity = T < SLOT_BORN ? .3 : 1;

  /* journals visibly fill up: the count is the number of entries written so far */
  document.querySelectorAll('[data-base]').forEach(el => {
    const list = (jentries[el.id] || []).filter(e => T >= e.t);
    el.innerHTML = el.dataset.base + (list.length ? ` <b>#${list.length}</b>` : '');
    el.classList.toggle('glow', list.some(e => T >= e.t && T < e.t + 1.4));
  });

  let bi = 0;
  for (let i = 0; i < BEATS.length; i++) if (T >= BEATS[i].t) bi = i;
  const b = BEATS[bi], bp = Math.min(1, (T - b.t) / b.d);
  $('annoph').textContent = b.ph;
  $('annot').textContent = b.bt;
  $('annox').textContent = b.ax;
  $('beatct').textContent = (bi+1) + ' / ' + BEATS.length;
  $('clock').textContent = Math.floor(T) + 's';

  let sweepP = -1, gateHot = 0;
  document.querySelectorAll('.flashy').forEach(e => e.classList.remove('flashy'));
  const want = new Set();
  for (let ai = 0; ai < b.acts.length; ai++) {
    const a = b.acts[ai], s = a.s ?? 0, e = a.e ?? 1;
    if (bp < s || bp > e) continue;
    const p = (bp - s) / (e - s);
    if (a.k === 'tok') {
      const key = bi + ':' + ai;
      want.add(key);
      let tk = liveToks.get(key);
      if (!tk) { tk = tokSvg(a.kind); fx.appendChild(tk); liveToks.set(key, tk); }
      const pos = tokPos(a, p);
      if (pos) tk.setAttribute('transform', `translate(${pos.x},${pos.y})`);
      tk.setAttribute('opacity', p < .08 ? p/.08 : p > .92 ? (1-p)/.08 : 1);
      if (a.kind === 'refused') { if (p > .35 && p < .65) gateHot = -1; }
      else if (KINDS[a.kind].gate && p > .38 && p < .52) gateHot = gateHot || 1;
      if (a.ent) { const j = JMAP[a.f]; if (j && $(j)) $(j).classList.add('glow'); }
    }
    if (a.k === 'flash') { const el = $(a.w); if (el) el.classList.add('flashy'); }
    if (a.k === 'sweep') sweepP = p;
  }
  for (const [key, el] of liveToks) if (!want.has(key)) { el.remove(); liveToks.delete(key); }
  const g = $('rp-gate');
  g.classList.toggle('hot', gateHot === 1);
  g.classList.toggle('deny', gateHot === -1);
  const sw = $('sweep');
  if (sweepP >= 0) {
    const rw = $('repo').getBoundingClientRect().width;
    sw.style.opacity = 1; sw.style.left = (sweepP * (rw - 56)) + 'px';
    $('rp-ci').classList.add('hot');
  } else { sw.style.opacity = 0; $('rp-ci').classList.remove('hot'); }

  drawWires();
  if (openCard && openCard.kind === 'journal') paintJournal(openCard.id);
  $('scrub').value = T;
}
window.seek = t => { T = Math.max(0, Math.min(TOTAL, t)); render(); };

function frame(ts) {
  if (playing) {
    const dt = Math.min(.1, (ts - lastFrame) / 1000);
    T += dt * speed;
    if (T >= TOTAL) { T = TOTAL; setPlay(false); }
    render();
  }
  lastFrame = ts;
  requestAnimationFrame(frame);
}
function setPlay(p) {
  if (p && T >= TOTAL - .1) T = 0;
  playing = p;
  $('play').innerHTML = p ? '&#10074;&#10074; PAUSE' : '&#9654; PLAY';
}
$('play').addEventListener('click', () => setPlay(!playing));
$('spd').addEventListener('click', () => {
  speed = speed === 1 ? 2 : speed === 2 ? 0.5 : 1;
  $('spd').textContent = (speed === 0.5 ? '½' : speed) + '×';
});
$('scrub').addEventListener('input', e => { T = +e.target.value; render(); });

const phl = $('phlabels'), seen = new Set();
for (const b of BEATS) if (!seen.has(b.ph)) {
  seen.add(b.ph);
  const sp = document.createElement('span');
  sp.textContent = b.ph; sp.style.left = (b.t / TOTAL * 100) + '%';
  sp.addEventListener('click', () => { setPlay(false); seek(b.t); });
  phl.appendChild(sp);
}

/* ---- click descriptions ---- */
const SEATNAME = { 'jr-orch':'Orchestrator','jr-spec':'Specification lead','jr-impl':'Implementation lead',
  'jr-verif':'Verification lead','jr-audit':'Auditor','jr-workers':'Workers' };
const DATA = __DATA__;

function paintJournal(jid) {
  const list = (jentries[jid] || []).filter(e => T >= e.t);
  let h = `<div class="dx">${DATA.journal[1]}</div>`;
  h += `<div class="jbox"><div class="jhead">${SEATNAME[jid]} &#183; ${
    list.length ? list.length + (list.length === 1 ? ' entry' : ' entries') + ' so far' : 'no entries yet'}</div>`;
  if (!list.length) h += `<div class="jempty">This seat has not committed anything at this point in the '
    + 'project. An empty journal is a true statement, not a missing one.</div>`;
  list.forEach((e, i) => {
    h += `<div class="jent"><span class="jn">#${i+1}</span><span>${esc(e.title)}${
      e.by ? `<em> — ${esc(e.by)}</em>` : ''}</span></div>`;
  });
  h += `</div>`;
  $('dett').textContent = SEATNAME[jid] + ' journal';
  $('detx').innerHTML = h;
  $('dhint').textContent = 'live — scrub and watch it fill';
}
document.addEventListener('click', e => {
  const el = e.target.closest('[data-i]');
  if (!el || el.classList.contains('unborn')) return;
  if (el.dataset.i === 'journal' && el.id) { openCard = { kind:'journal', id: el.id }; paintJournal(el.id); return; }
  const d = DATA[el.dataset.i]; if (!d) return;
  openCard = { kind:'static' };
  $('dett').textContent = d[0]; $('detx').textContent = d[1];
  $('dhint').textContent = 'from the framework';
});

function sizeFx() {
  const r = stage.getBoundingClientRect();
  fx.setAttribute('width', r.width); fx.setAttribute('height', r.height);
  fx.setAttribute('viewBox', `0 0 ${r.width} ${r.height}`);
}
addEventListener('resize', () => { sizeFx(); render(); });
if (document.fonts && document.fonts.ready) document.fonts.ready.then(() => { sizeFx(); render(); });
sizeFx();
$('scrub').max = TOTAL;
render();
requestAnimationFrame(frame);
