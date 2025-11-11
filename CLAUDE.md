# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal academic website built with Hugo using the Wowchemy Academic theme (v5). The site showcases publications, blog posts, projects, and professional information. It's deployed on Netlify.

**Site URL**: https://franciscowilhelm.com/
**Repository**: https://github.com/franciscowilhelm/personal-hp
**Main Branch**: 53_clean

## Build & Development Commands

### Local Development
```bash
# Start development server with live reload
./view.sh
# Or manually:
hugo server --disableFastRender --i18n-warnings
```

### Building
```bash
# Production build (as used by Netlify)
hugo --gc --minify -b https://franciscowilhelm.com/

# Preview build
hugo --gc --minify --buildFuture -b <PREVIEW_URL>
```

### Updating Wowchemy Theme
```bash
# Update Hugo modules and Netlify Hugo version
./update_wowchemy.sh

# Manual update
hugo mod get -u ./...
hugo mod tidy
```

## Architecture

### Content Structure

The site uses Hugo's content organization with Wowchemy's widget-based page builder:

- **`content/home/`**: Homepage widgets (about, publications, posts, projects, etc.)
  - Each `.md` file is a widget with frontmatter controlling display order and settings
  - Widgets use the `headless: true` parameter and are ordered by `weight`

- **`content/authors/admin/`**: Author profile (biographical info, photo, social links)
  - This profile is referenced by widgets using `author: admin`

- **`content/post/`**: Blog posts
  - Posts are written in RMarkdown (`.Rmd`) and rendered to HTML
  - Topics focus on R, statistics, and psychometrics
  - Each post typically includes YAML frontmatter with title, date, tags, etc.

- **`content/publication/`**: Academic publications
  - Each publication in its own folder with `index.md`
  - Frontmatter includes publication type, authors, abstract, URLs (code, PDF, etc.)
  - Uses `publication_types` taxonomy (0=Uncategorized, 1=Conference, 2=Journal, etc.)

- **`content/project/`**: Project showcase
- **`content/event/`**: Talks and presentations

### Configuration

Configuration is split across multiple YAML files in `config/_default/`:

- **`config.yaml`**: Core Hugo settings, modules, taxonomies, permalinks
- **`params.yaml`**: Wowchemy theme settings (appearance, features, SEO, extensions)
- **`menus.yaml`**: Navigation menu configuration
- **`languages.yaml`**: Internationalization settings

### Theme & Modules

The site uses Hugo Modules (not Git submodules) to import Wowchemy:

```yaml
module:
  imports:
    - github.com/wowchemy/wowchemy-hugo-themes/modules/wowchemy-plugin-netlify-cms
    - github.com/wowchemy/wowchemy-hugo-themes/modules/wowchemy-plugin-netlify
    - github.com/wowchemy/wowchemy-hugo-themes/modules/wowchemy-plugin-reveal
    - github.com/wowchemy/wowchemy-hugo-themes/modules/wowchemy/v5
```

Dependencies are managed via `go.mod` and `go.sum`.

### Data Files

- **`data/themes/`**: Custom theme definitions
- **`data/fonts/`**: Custom font configurations
- **`data/page_sharer.toml`**: Social sharing button configuration

## Content Creation Workflows

### Adding a Blog Post

1. Create a new `.Rmd` file in `content/post/` with naming pattern: `YYYY-MM-DD-title.Rmd`
2. Include YAML frontmatter:
   ```yaml
   ---
   title: "Post Title"
   author: Francisco Wilhelm
   date: 'YYYY-MM-DD'
   tags: [tag1, tag2]
   slug: post-slug
   ---
   ```
3. Write content using RMarkdown (supports R code chunks, LaTeX math)
4. Knit to HTML (creates `.html` file alongside `.Rmd`)

### Adding a Publication

1. Create folder in `content/publication/publication-name/`
2. Add `index.md` with frontmatter including:
   - `title`, `authors`, `date`, `publication_types`
   - `publication` (full journal/venue name)
   - `abstract`, `summary`
   - URLs: `url_pdf`, `url_code`, `url_source`, etc.
3. Optionally add `featured.jpg` for thumbnail

### Modifying Homepage

Edit widget files in `content/home/`:
- Toggle visibility with `active: true/false`
- Reorder sections by changing `weight` values
- Configure widget-specific settings in frontmatter

## Deployment

### Netlify Configuration

- **Build command**: `hugo --gc --minify -b $URL`
- **Publish directory**: `public`
- **Hugo version**: 0.113.0 (specified in `netlify.toml`)
- **Plugin**: `netlify-plugin-hugo-cache-resources` for faster builds

### Environment Variables

- `HUGO_VERSION`: 0.113.0
- `HUGO_ENABLEGITINFO`: true
- `HUGO_ENV`: production (in production context)

## Important Notes

- Git info is disabled (`enableGitInfo: false`) despite Netlify setting
- Current branch `53_clean` is set as the repository branch in params
- The site ignores: `.ipynb`, `.ipynb_checkpoints`, `.Rmd`, `.Rmarkdown`, `_cache`
- Timeout is set to 600000ms (10 minutes) for long builds
- Image processing uses Lanczos resampling at 75% quality
