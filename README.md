# personal-hp

Personal academic website for Francisco Wilhelm, built with Hugo and the HugoBlox Academic CV template and deployed on Netlify.

## Stack

- HugoBlox `modules/blox v0.12.0`
- HugoBlox Netlify integration `v1.3.0`
- Hugo `0.159.2` in project config/Netlify
- Tailwind CSS v4 via the HugoBlox toolchain
- Pagefind for search indexing during builds

## Local development

Requirements:

- Hugo Extended
- Go
- Node.js with `pnpm`

Commands:

```bash
pnpm install
hugo server --disableFastRender
```

Production-equivalent build:

```bash
pnpm install
hugo --gc --minify -b https://franciscowilhelm.com/
pnpm dlx pagefind --site public
```

## Content structure

- `content/_index.md`: homepage blocks
- `content/authors/admin/`: primary profile
- `content/publications/`: publications
- `content/blog/`: blog posts, with `.qmd` sources kept alongside rendered Markdown where applicable
- `content/courses/`: teaching content

## Deployment

Netlify uses `netlify.toml` and the Hugo version pinned in `hugoblox.yaml` / `netlify.toml`.

The build pipeline:

1. Installs Node dependencies with `pnpm`
2. Builds the site with Hugo
3. Generates Pagefind search assets from `public/`

## Notes

- Custom head hook overrides live in `layouts/_partials/hooks/head-end/`
- Custom CSS overrides live in `assets/css/custom.css`
- Search assets are generated at build time; do not commit `public/`
