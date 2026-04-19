# Branch Canonicalization Plan

## Goal

Make the current HugoBlox site branch the long-term canonical branch without merging into stale legacy branches.

Target end state:

- the current site history remains the source of truth
- the canonical branch name becomes `main`
- `53_clean` and `master` are kept only as short-term archival branches and deleted later

## Current State Snapshot

Captured from the local repo and linked Netlify project on 2026-04-19.

Git branches:

- current local branch: `hugo-blox-migration`
- current upstream tracking branch: `origin/hugo-blox-migration`
- local branches present: `hugo-blox-migration`, `53_clean`
- remote branches present on `origin`: `hugo-blox-migration`, `53_clean`, `master`
- `origin/HEAD` already points to `origin/hugo-blox-migration`

Relevant commit refs:

- `hugo-blox-migration`: `89fbcc405d11823655d1b8edf54fbf2e04b88eea`
- `53_clean`: `d92ef0cb58dae209afc45120fd264f46fef6e8be`
- `master`: `70287253c51bd7b86d97117ca570b74b7cc399e4`

Deployment state:

- Netlify site: `franciscowilhelm`
- production URL: `https://www.franciscowilhelm.com`
- current ready deploy id: `69e490f181d0b5000808522f`
- current production commit: `89fbcc405d11823655d1b8edf54fbf2e04b88eea`
- Netlify is already serving the `hugo-blox-migration` branch lineage

Local repo caveats at the time of writing:

- there is an existing stash entry for isolated post work: `codex: isolate fornell-larcker upgrade preflight`
- there are unrelated uncommitted local changes, so any branch rename/delete work should start from a clean worktree

## Why Not Merge Into `master` or `53_clean`

Do not merge `hugo-blox-migration` into `master` or `53_clean`.

Reasons:

- both legacy branches are materially older than the live site history
- they reflect obsolete upstream/theme structure
- a merge would add conflict risk and low-signal history noise
- Netlify production already tracks the current branch lineage, so a merge gives no deployment advantage

The correct strategy is branch replacement, not branch reconciliation.

## Canonicalization Strategy

Use `hugo-blox-migration` as the source of truth immediately, then rename that branch to `main` after a validation window.

Sequence:

1. Keep `hugo-blox-migration` as the GitHub default branch during the validation window.
2. Continue pushing site changes only to `hugo-blox-migration`.
3. After validation, rename `hugo-blox-migration` to `main`.
4. Confirm GitHub default branch and Netlify production both track the renamed branch.
5. Keep `53_clean` and `master` temporarily as archival references.
6. Delete `53_clean` and `master` after the validation window closes.

## Preconditions Before Rename

Before renaming the branch:

- ensure the working tree is clean
- ensure any wanted local changes are committed or stashed
- confirm the intended latest commit is pushed to `origin/hugo-blox-migration`
- confirm Netlify production and branch deploys are healthy
- confirm no open work still depends on the branch name `hugo-blox-migration`

Recommended verification commands:

```bash
git status --short --branch
git rev-parse HEAD
git rev-parse origin/hugo-blox-migration
git branch -a
```

## Rename Procedure

### GitHub

Preferred path: rename the default branch in GitHub from `hugo-blox-migration` to `main`.

Expected outcome:

- GitHub keeps branch history intact
- redirects from old branch URLs continue to work
- the repository default branch becomes `main`

If using the GitHub web UI:

1. Open repository branch settings.
2. Rename branch `hugo-blox-migration` to `main`.
3. Confirm the default branch remains the renamed branch.

If using API or CLI later, only do so with authenticated GitHub access.

### Local Repo After Remote Rename

After GitHub completes the rename, update the local clone:

```bash
git fetch origin --prune
git branch -m hugo-blox-migration main
git branch --unset-upstream
git branch -u origin/main main
git remote set-head origin -a
```

Then verify:

```bash
git status --short --branch
git rev-parse --abbrev-ref HEAD
git rev-parse --abbrev-ref --symbolic-full-name @{u}
git branch -a
```

Expected result:

- local checked-out branch is `main`
- upstream is `origin/main`
- `origin/HEAD` points to `origin/main`

## Post-Rename Hygiene

After the rename:

- update any docs that still refer to `hugo-blox-migration` as the long-term branch name
- update any automation or workflow references that assume `master`, `53_clean`, or `hugo-blox-migration`
- confirm Netlify continues deploying the renamed canonical branch
- confirm collaborators can fetch and track `main` cleanly

Suggested checks:

```bash
git grep -n "hugo-blox-migration\\|53_clean\\|master"
```

Review each hit and keep only intentional historical references.

## Validation Window

Keep `53_clean` and `master` during a short validation window after the rename.

Recommended minimum checks during that window:

- production site loads correctly
- branch deploys still work
- local development still works from `main`
- there are no automation failures tied to branch naming
- no one reports missing history or broken links

A reasonable window is 1-2 weeks or until the next successful site/content update lands on `main`.

## Legacy Branch Retirement

After the validation window:

1. Confirm no needed work remains on `53_clean` or `master`.
2. Delete the remote legacy branches.
3. Prune local stale refs.

Commands:

```bash
git push origin --delete 53_clean
git push origin --delete master
git fetch origin --prune
```

Optional local cleanup:

```bash
git branch -d 53_clean
```

Do not delete the local archival branch unless its history is no longer needed locally.

## Rollback Plan

If rename-related problems appear before legacy branches are deleted:

- keep using the renamed canonical branch history
- fix GitHub or Netlify branch settings rather than merging old branches
- use `53_clean` or `master` only as reference points, not merge targets

If a critical issue requires temporary comparison:

```bash
git checkout 53_clean
git checkout master
git checkout main
```

## Decision Summary

- canonical lineage: `hugo-blox-migration`
- final canonical branch name: `main`
- no merge into `master`
- no merge into `53_clean`
- `53_clean` and `master` are temporary archival branches only
