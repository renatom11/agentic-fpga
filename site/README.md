# agentic-fpga showcase site

A static site presenting the project: overview, the three interactive
artifacts (block diagram, spec atlas, org chart), and a live backlog page.

## Deploy (Cloudflare, wrangler)

```sh
cd site
npx wrangler deploy
```

That serves `public/` as static assets on your workers.dev subdomain (or a
route you attach). Nothing else to configure — every page is fully
self-contained (fonts inlined, no external requests), so it works on any
static host.

## Refresh

- `python3 site/build.py` — regenerates `index.html` and `backlog.html`
  from the repository state (board, journals, git). Run after the program
  moves, then redeploy.
- The three artifact pages are self-contained snapshots produced by their
  own generators; replace them when the artifacts are rebuilt.
