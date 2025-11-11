# Hugo Blox Migration Plan

## Current Status: Phases 1-7 Complete ✅ Ready for Deployment 🚀

**Branch**: `hugo-blox-migration`
**Last Updated**: 2025-11-11

### Completed Phases:
- ✅ **Phase 1**: Setup new Hugo Blox Academic CV site (commit: 2e061bb)
- ✅ **Phase 2**: Migrated author profile and homepage (commit: 2831349)
- ✅ **Phase 3**: Migrated 7 publications + updated citations (commits: 6bfd268, 867bdf3)
- ✅ **Phase 4**: Migrated 4 blog posts (commit: 4c520ae)
- ✅ **Phase 5**: Added teaching section with multilevel models course (commit: 1d89a31)
- ✅ **Phase 6**: Copied site icon (icon.png) from old site (commit: 1d89a31)
- ✅ **Phase 7**: Testing & QA complete (commit: 1d89a31)
  - Homepage restructured: About Me → Selected Publications → Recent Posts → Contact
  - Publications page created with full list
  - Navigation updated to include Teaching
  - All download links added to publications
  - Demo content removed (projects, events)
  - Build: 82 pages, 555ms, zero errors
  - Comprehensive testing report: TESTING_REPORT.md

### Current Site Stats:
- **Pages**: 82 (production build)
- **Publications**: 7 (including 3 new 2025 papers, 4 marked as "selected")
- **Blog Posts**: 4
- **Courses**: 1 (Multilevel Models for Diary Studies)
- **Build Status**: ✅ Successful, no errors, no warnings
- **SEO**: ✅ Sitemap and robots.txt generating correctly

### Next Steps:
- 🚀 **Phase 8**: Netlify deployment (in progress)
- Phase 9: Go live and final monitoring

---

## Strategy: New Branch Approach (Recommended)

### Why New Branch vs New Repo?

**Recommended: New Branch**
- ✅ Keeps git history and context
- ✅ Easy to reference old structure side-by-side
- ✅ Netlify already configured for this repo
- ✅ Can create preview deploys for testing
- ✅ Simple rollback if issues arise
- ✅ PR workflow for review before merging to main
- ✅ Preserve old site on current branch as backup

**Alternative: New Repo**
- ❌ Lose git history
- ❌ Need to reconfigure Netlify
- ❌ Harder to reference old implementation
- ✅ Truly clean slate
- ✅ No risk of confusion with old files

**Decision: Use new branch `hugo-blox-migration`**

---

## Migration Phases

### Phase 1: Setup New Hugo Blox Site (Branch)

1. **Create new branch from current main/53_clean**
   ```bash
   git checkout -b hugo-blox-migration
   ```

2. **Backup current content**
   ```bash
   mkdir _OLD_SITE_BACKUP
   mv content/ _OLD_SITE_BACKUP/
   mv config/ _OLD_SITE_BACKUP/
   mv data/ _OLD_SITE_BACKUP/
   # Keep: go.mod, go.sum, netlify.toml (will be updated)
   ```

3. **Initialize new Hugo Blox Academic Resume template**
   - Option A: Download latest template from https://hugoblox.com/templates/
   - Option B: Use Hugo Blox CLI/starter
   - Extract core structure into repo root

4. **Update `netlify.toml`**
   - Update Hugo version to latest compatible (likely 0.130+)
   - Keep build command: `hugo --gc --minify -b $URL`
   - Keep publish dir: `public`

5. **Update `go.mod`**
   - Replace Wowchemy modules with Hugo Blox modules
   - Point to: `github.com/HugoBlox/hugo-blox-builder/modules/*`

6. **Test clean build**
   ```bash
   hugo mod get -u
   hugo mod tidy
   hugo server
   ```

### Phase 2: Migrate Core Identity & Configuration

**Priority Order:**

#### 2.1 Author Profile (`content/authors/admin/`)
- Copy from: `_OLD_SITE_BACKUP/content/authors/admin/`
- Update `_index.md` frontmatter to match new Hugo Blox schema
- Migrate: bio, photo, social links, interests, education
- **Test**: Verify profile displays correctly

#### 2.2 Site Configuration
From `_OLD_SITE_BACKUP/config/_default/`:
- **`config.yaml`**: Map old settings to new structure
  - Title, baseURL, copyright
  - Language settings
  - Taxonomies (tags, categories, publication_types, authors)
- **`params.yaml`**: Map to new Hugo Blox params
  - Appearance (theme, fonts)
  - SEO settings
  - Header/footer config
  - Features (syntax highlighting, math, search)
- **`menus.yaml`**: Recreate navigation menu

#### 2.3 Homepage Widgets (`content/home/`)
- Start with default Hugo Blox widgets
- Customize one-by-one:
  - About/Biography widget
  - Publications widget
  - Blog posts widget
  - Projects widget
  - Skills/Experience (if keeping)
  - Contact widget
- Match old `weight` ordering
- Enable/disable as needed (`active: true/false`)

**Checkpoint**: Site structure matches old homepage layout

### Phase 3: Migrate Publications

**Publications are high-value, low-risk content**

#### 3.1 Test Migration (Single Publication)
- Copy one publication folder from `_OLD_SITE_BACKUP/content/publication/`
- Update `index.md` frontmatter to match Hugo Blox schema
- Common changes needed:
  - `publication_types` format
  - Date format
  - URL fields naming
  - Image/featured image syntax
- **Test**: Build and verify display

#### 3.2 Bulk Migration Script
Create `scripts/migrate_publications.py` or bash script:
```python
# Pseudo-code
for each publication in _OLD_SITE_BACKUP/content/publication/:
    copy folder to content/publication/
    update index.md frontmatter:
        - normalize dates
        - update publication_types syntax
        - verify URL fields
        - check image paths
```

#### 3.3 Validation
- Count: Ensure all publications migrated
- Spot-check: Random sample of 5-10 publications
- Test: Filter by publication type, tags
- Fix: Any formatting issues found

**Checkpoint**: All publications display correctly

### Phase 4: Migrate Blog Posts

**Blog posts are LOW RISK - Hugo only uses .html outputs**

#### Key Finding: Current Architecture
- `.Rmd` files are **completely ignored** by Hugo (see `config.yaml` line 41: `ignoreFiles: [\.Rmd$, \.Rmarkdown$]`)
- Hugo **only processes** the `.html` files (which contain YAML frontmatter + rendered HTML)
- The `.Rmd` → `.html` rendering happens **outside Hugo** (via RMarkdown/knitr)
- This means: **Hugo Blox doesn't need to support RMarkdown at all!**

#### Migration Strategy: Switch to Quarto (.qmd)
Since Hugo never touches the source files, we can safely switch from RMarkdown to Quarto:
- Rename `.Rmd` → `.qmd` (or keep both during transition)
- Render with Quarto instead of knitr
- As long as Quarto produces `.html` with same structure, Hugo won't know the difference

#### 4.1 Test Migration (Single Post)
- Copy one post folder (`.Rmd` + `.html` files) from `_OLD_SITE_BACKUP/content/post/`
- **Option A**: Keep `.Rmd`, just copy `.html` to new site
- **Option B**: Convert `.Rmd` → `.qmd`, render with Quarto to test
- Update YAML frontmatter in `.html` to match Hugo Blox schema (if needed)
- **Test**: Verify rendering, code chunks, images, math

#### 4.2 Verify Quarto Rendering (Optional)
If switching to Quarto:
```bash
# Install Quarto if not already installed
# Convert one .Rmd to .qmd (usually just rename)
quarto render content/post/2022-01-17-fornell-larcker-test.qmd
```
- Compare old `.html` vs new Quarto-generated `.html`
- Verify: YAML frontmatter preserved, paths correct, styling compatible

#### 4.3 Bulk Migration
- Copy all `.html` files to new Hugo Blox site
- Optionally: Copy or convert source files (`.Rmd` or `.qmd`) for future editing
- Update YAML frontmatter in `.html` files if Hugo Blox schema differs
- Validate rendering on all posts
- Fix any image paths or internal links if needed

#### 4.4 Update Workflow Documentation
- Document: Use Quarto for rendering future posts (more future-proof than RMarkdown)
- Update `.gitignore` or Hugo config if switching to `.qmd`
- Keep source files (`.qmd`) alongside `.html` in git for future edits

**Checkpoint**: All blog posts accessible and readable

### Phase 5: Migrate Additional Content ✅

#### 5.1 Projects (`content/project/`)
- ✅ Skipped - only contains example content.

#### 5.2 Events/Talks (`content/event/`)
- ✅ Skipped - only contains example content.

#### 5.3 Teaching Section ✅
- ✅ Created `content/courses/multilevel-models/` directory
- ✅ Added course page with German description: "Dieses Dokument enthält Anleitungen und Übungen zur Analyse von Daten aus Tagebuchstudien mittels Mehrebenenmodellen. Es ist im Rahmen des Seminars zu Tagebuchstudien in Psychologie an der Uni Bern entstanden."
- ✅ Included link to https://franciscowilhelm.github.io/multilevel_course/
- ✅ Added "Teaching" link to navigation menu (weight: 35, between Publications and Contact)
- ✅ Removed demo Hugo Blox course
- ✅ Site builds successfully with new content

### Phase 6: Customization & Styling ✅

- ✅ Copied icon.png from `_OLD_SITE_BACKUP/assets/media/icon.png` to `assets/media/icon.png`
- Site rebuilt successfully with icon (359ms)
- Other customizations disregarded as they may no longer be compatible with Hugo Blox 2025

### Phase 7: Testing & QA ✅

#### 7.1 Local Testing
- ✅ Homepage loads and matches old layout, within the bounds of the new
- ✅ All publications display (7 total)
- ✅ All blog posts render (4 total)
- ✅ Navigation menu works (Home, Posts, Publications, Teaching, Contact)
- ⚠️ Search functionality - requires browser interaction (not tested)
- ✅ Contact section displays correctly
- ✅ Social links work
- ⚠️ Mobile responsive - requires device testing (not tested)
- ⚠️ Dark/light theme toggle - requires browser interaction (not tested)

#### 7.2 Content Audit
- ✅ Internal links work (navigation, anchors)
- ✅ External links work (publications, teaching)
- ✅ Images load (58 images processed, icon.png present)
- ✅ PDFs/downloads accessible (4 publication download links working)
- ✅ Code blocks render with syntax highlighting
- ✅ Math formulas support enabled

#### 7.3 SEO/Metadata
- ✅ Page titles correct
- ✅ Homepage metadata updated (date: 2025-11-11)
- ⚠️ Open Graph tags - automatically generated by Hugo Blox (not inspected)
- ⚠️ Twitter cards - automatically generated by Hugo Blox (not inspected)
- ✅ Sitemap generates correctly (82 URLs, 6.9KB)
- ✅ robots.txt correct (points to https://franciscowilhelm.com/sitemap.xml)

**Testing Status**: Core functionality verified. See TESTING_REPORT.md for comprehensive results.

### Phase 8: Netlify Deployment

#### 8.1 Preview Deploy
- Push `hugo-blox-migration` branch
- Netlify should auto-create preview URL
- Test on real deployment
- Check build logs for warnings

#### 8.2 Performance Check
- Build time acceptable?
- Page load speed
- Lighthouse audit
- Image optimization

#### 8.3 Final Review
- Compare old site vs new site side-by-side
- Check all major pages
- Get feedback from colleague/friend

### Phase 9: Go Live

#### 9.1 Pre-Launch Checklist
- [ ] All content migrated
- [ ] All links work
- [ ] No broken images
- [ ] Analytics configured (if desired)
- [ ] Backup of old site branch
- [ ] Domain/baseURL configured correctly

#### 9.2 Merge Strategy
```bash
# Option A: Direct merge to 53_clean
git checkout 53_clean
git merge hugo-blox-migration

# Option B: New main branch
git checkout -b main
git merge hugo-blox-migration
# Update Netlify to deploy from 'main'

# Option C: Make migration branch the new main
# In GitHub: Change default branch to hugo-blox-migration
# In Netlify: Update production branch
```

#### 9.3 Monitor
- Watch Netlify deploy
- Check live site immediately
- Monitor for 24-48 hours
- Check analytics for issues
- Be ready to rollback if critical issues

### Phase 10: Cleanup

#### 10.1 Archive Old Site
- Keep `53_clean` branch as backup
- Add README noting it's archived
- Tag as `archive/wowchemy-v5-final`

#### 10.2 Update Documentation
- Update main README.md
- Update CLAUDE.md with new structure
- Document any migration quirks
- Remove `MIGRATION_PLAN.md` or archive it

---

## Content Migration Mapping

### Directory Structure Changes

| Old (Wowchemy v5) | New (Hugo Blox) | Notes |
|-------------------|-----------------|-------|
| `content/author/` | `content/authors/` | May need plural |
| `content/post/` | `content/posts/` or `content/post/` | Check Hugo Blox convention |
| `content/publication/` | `content/publications/` or `content/publication/` | Check Hugo Blox convention |
| `config/_default/` | `config/_default/` | Same, but schema changes |
| `data/themes/` | `data/themes/` or built-in | May not need custom |
| `layouts/partials/blocks/v1/` | `layouts/partials/blocks/` | Template location change |

### Frontmatter Field Changes

**Publications:**
```yaml
# Old
publication_types: ["2"]
date: 2018-06-19

# New (verify Hugo Blox schema)
publication_types:
  - article-journal
date: 2018-06-19T00:00:00Z
```

**Blog Posts:**
```yaml
# Old
slug: post-slug
tags: [tag1, tag2]

# New (likely similar)
slug: post-slug
tags:
  - tag1
  - tag2
```

### Configuration Mapping

**Old `config.yaml` → New `hugo.yaml`:**
- Module imports: Wowchemy → Hugo Blox paths
- Hugo version: 0.113.0 → 0.130.0+ (check latest)

**Old `params.yaml` → New `params.yaml`:**
- Theme names may change
- Feature flags syntax may differ
- Repository URL update

---

## Rollback Plan

If migration fails or issues arise:

1. **During preview**: Just abandon branch, stay on `53_clean`
2. **After merge**:
   ```bash
   git revert <merge-commit>
   git push origin 53_clean --force
   ```
3. **Nuclear option**: Point Netlify back to `53_clean` branch

---

## Timeline Estimate

| Phase | Estimated Time | Blocker Risk |
|-------|---------------|--------------|
| Setup (Phase 1) | 1-2 hours | Low |
| Core Config (Phase 2) | 2-3 hours | Medium |
| Publications (Phase 3) | 2-4 hours | Low |
| Blog Posts (Phase 4) | 1-3 hours | **Low** (just copy .html files) |
| Additional Content (Phase 5) | 1-2 hours | Low |
| Customization (Phase 6) | 1-3 hours | Low |
| Testing (Phase 7) | 2-4 hours | Medium |
| Deploy (Phase 8-9) | 1-2 hours | Medium |

**Total: 11-21 hours** depending on issues encountered

**Biggest Risk**: Configuration schema changes in Hugo Blox vs Wowchemy v5

---

## Open Questions to Research

1. ~~**Does Hugo Blox 2025 still support RMarkdown directly?**~~ ✅ **ANSWERED**
   - **Not needed!** Hugo never processes .Rmd files - it only uses the pre-rendered .html outputs
   - Can safely switch to Quarto (.qmd) for future posts without any Hugo changes

2. **Folder naming: singular vs plural?**
   - `content/post/` or `content/posts/`?
   - `content/publication/` or `content/publications/`?

3. **Hugo version compatibility?**
   - What's the minimum Hugo version for Hugo Blox?
   - Any breaking changes in Hugo 0.113 → 0.130+?

4. **Publication types taxonomy?**
   - Still numeric codes or moved to semantic names?

5. **Custom layouts/partials?**
   - Where do overrides go in Hugo Blox?

---

## Success Criteria

- [ ] All publications visible and correctly formatted
- [ ] All blog posts readable (code, images, math working)
- [ ] Homepage matches old site's general layout
- [ ] Site builds in under 5 minutes
- [ ] No broken links
- [ ] Mobile responsive
- [ ] Same or better Lighthouse scores
- [ ] You're happy with the result!
