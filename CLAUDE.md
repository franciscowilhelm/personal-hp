# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal academic website built with Hugo using the Hugo Blox Academic CV theme. The site showcases publications, blog posts, and professional information. It's deployed on Netlify.

**Site URL**: https://franciscowilhelm.com/
**Repository**: https://github.com/franciscowilhelm/personal-hp
**Main Branch**: 53_clean
**Migration Branch**: hugo-blox-migration (Hugo Blox v2025 migration in progress)

## Current Status: MIGRATION IN PROGRESS

**Branch**: `hugo-blox-migration`
**Status**: Core content migration complete (Phases 1-4)

### Completed:
- ✅ Phase 1: Setup new Hugo Blox Academic CV site
- ✅ Phase 2: Migrated author profile and customized homepage
- ✅ Phase 3: Migrated 7 publications
- ✅ Phase 4: Migrated 4 blog posts

### Remaining:
- Phase 5: Static files, additional content
- Phase 6: Customization & styling
- Phase 7-9: Testing & deployment

See MIGRATION_PLAN.md for detailed progress.

## Build & Development Commands

### Local Development
```bash
# Start development server with live reload
hugo server --disableFastRender

# Or use the convenience script
./view.sh
```

### Building
```bash
# Production build (as used by Netlify)
hugo --gc --minify -b https://franciscowilhelm.com/

# Preview build
hugo --gc --minify --buildFuture -b <PREVIEW_URL>
```

### Updating Hugo Blox Modules
```bash
# Update Hugo modules
hugo mod get -u ./...
hugo mod tidy
```

## Architecture

### Content Structure

The site uses Hugo's content organization with Hugo Blox's block-based page builder:

- **`content/authors/admin/`**: Author profile (biographical info, photo, social links)
  - Uses new Hugo Blox schema with `profiles` for social links
  - Education with date ranges

- **`content/_index.md`**: Homepage with sections:
  - `resume-biography-3` block for profile
  - `collection` blocks for blog posts and publications
  - `markdown` block for contact info

- **`content/blog/`**: Blog posts (migrated from old `content/post/`)
  - Posts written in RMarkdown (`.Rmd`) and rendered to `.md` (previously `.html`)
  - Hugo only processes `.md` files; `.Rmd` files are ignored
  - Topics focus on R, statistics, and psychometrics
  - Each post in its own folder with `index.md`

- **`content/publications/`**: Academic publications
  - Each publication in its own folder with `index.md`
  - Frontmatter uses Hugo Blox schema:
    - `publication_types`: Semantic names (e.g., "article-journal", "chapter")
    - `hugoblox.ids.doi`: DOI identifier
    - `links`: Structured array for URLs
  - Includes `.bib` files for citations

- **`content/projects/`**, **`content/events/`**, **`content/courses/`**: Additional sections (demo content to be replaced/removed)

### Configuration

Configuration is split across multiple YAML files in `config/_default/`:

- **`hugo.yaml`**: Core Hugo settings, modules, taxonomies, permalinks
- **`params.yaml`**: Hugo Blox theme settings (appearance, features, SEO, extensions)
- **`menus.yaml`**: Navigation menu configuration
- **`module.yaml`**: Hugo module imports
- **`languages.yaml`**: Internationalization settings

### Theme & Modules

The site uses Hugo Modules to import Hugo Blox:

```yaml
module:
  imports:
    - github.com/HugoBlox/hugo-blox-builder/modules/blox-plugin-netlify
    - github.com/HugoBlox/hugo-blox-builder/modules/blox-tailwind
```

Dependencies are managed via `go.mod` and `go.sum`.

### Data Files

- No custom data files currently (old `data/` directory backed up)

## Content Creation Workflows

### Adding a Blog Post

1. Create `.qmd` file (Quarto) or `.Rmd` (RMarkdown) in a new folder: `content/blog/your-post-slug/`
2. Include YAML frontmatter:
   ```yaml
   ---
   title: "Post Title"
   authors:
   - Francisco Wilhelm
   date: 'YYYY-MM-DD'
   tags:
     - tag1
     - tag2
   slug: post-slug
   featured: false
   ---
   ```
3. Write content using Quarto/RMarkdown (supports R code chunks, LaTeX math)
4. Render to `.md` file (e.g., `index.md`)
5. Hugo processes the `.md` file; source files (`.qmd`/`.Rmd`) are ignored

### Adding a Publication

1. Create folder in `content/publications/publication-slug/`
2. Add `index.md` with frontmatter:
   ```yaml
   ---
   title: "Publication Title"
   authors:
   - Author Name
   date: "YYYY-MM-DD"
   publication_types: ["article-journal"]  # or "chapter", "software", etc.
   publication: "*Journal Name*"
   abstract: "..."
   hugoblox:
     ids:
       doi: 10.xxxx/xxxxx
   links:
     - type: pdf
       url: https://...
   ---
   ```
3. Optionally add `cite.bib` for BibTeX citation
4. Optionally add `featured.jpg` for thumbnail

### Modifying Homepage

Edit `content/_index.md`:
- Add/remove/reorder sections in the `sections:` array
- Each section is a block (e.g., `collection`, `markdown`, `resume-biography-3`)
- Toggle visibility and customize content

## Deployment

### Netlify Configuration

- **Build command**: `hugo --gc --minify -b $URL`
- **Publish directory**: `public`
- **Hugo version**: 0.152.2 (specified in `netlify.toml`)
- **Node version**: 22
- **Go version**: 1.21.5
- **Plugins**: `netlify-plugin-hugo-cache-resources` for faster builds
- **Additional**: pnpm for TailwindCSS dependencies

### Environment Variables

- `HUGO_VERSION`: 0.152.2
- `HUGO_ENABLEGITINFO`: true
- `HUGO_ENV`: production (in production context)
- `GO_VERSION`: 1.21.5
- `NODE_VERSION`: 22

## Important Notes

- Git info is disabled in config (`enableGitInfo: false`) despite Netlify env var
- Current branch `hugo-blox-migration` contains the new Hugo Blox site
- Old site backed up in `_OLD_SITE_BACKUP/` directory
- The site ignores: `.ipynb`, `.ipynb_checkpoints`, `.Rmd`, `.Rmarkdown`, `_cache`
- Timeout is set to 600000ms (10 minutes) for long builds
- Image processing uses Lanczos resampling at 90% quality (upgraded from 75%)
- Math support is enabled in `params.yaml`

## Migration Notes

The site is currently being migrated from Wowchemy v5 to Hugo Blox 2025. The migration preserves all content while updating to the new theme's schema. Key changes:

- Publication types: Numeric codes → Semantic names
- DOI field: Top-level → `hugoblox.ids.doi`
- Social links: `social` array → `profiles` array
- Blog posts: `.html` extension → `.md` extension
- Folder structure: Same overall structure, new block-based homepage

See MIGRATION_PLAN.md for detailed migration strategy and progress.
