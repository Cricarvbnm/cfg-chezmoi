---
name: chezmoi-add-external
description: Add external dependencies (git repos, archives, files) to the chezmoi dotfiles repository. Use when asked to add a new external dependency, pull in a third-party config, or set up an externally-managed component.
---

# chezmoi-add-external

Add external dependencies to this chezmoi dotfiles repository. External dependencies are defined in `.chezmoiexternal.toml.tmpl` and downloaded separately via `chezmoi apply --refresh-externals`.

## When to Use

- Adding a new external dependency of any type
- Pulling in a third-party config or tool

## Choosing the Right Type

| Type | When to use | Rationale |
|------|------------|-----------|
| `git-repo` | You maintain the repo and need git features (push, branches, history) | Full clone with `.git/`. Use SSH URLs for repos you push to. |
| `archive` | You only need the files, not git history | Downloads a tarball — lighter than cloning. Use `include` to extract only needed subdirectories. `stripComponents = 1` is common because GitHub wraps archives in a top-level `repo-branch/` directory. |
| `file` | You need exactly one remote file | Most precise — downloads a single file. Choose over `archive` when you don't need the rest. |

General preference: prefer SSH for repos you maintain (convenient for pushing), prefer `archive` over `git-repo` for read-only content (avoids pulling entire git history), prefer `file` when a single file is all you need.

## Workflow

### 1. Edit `.chezmoiexternal.toml.tmpl`

The file uses the `.tmpl` extension because `.chezmoiexternal.toml` would cause editors to apply TOML formatting, breaking chezmoi template syntax (`{{ }}`). The `.tmpl` extension forces plain-text treatment.

Add the entry following existing patterns:

```toml
["<target-path>"]
type = "git-repo"
url = "ssh://..."
refreshPeriod = "168h"
```

Target path is relative to the home directory. Standard `refreshPeriod` is `168h` (weekly).

### 2. Verify Entry

Check that:
- The target path doesn't conflict with existing entries
- The type, URL, and refresh period are correct

### 3. Inform the User

Tell the user the entry was added. The user can test with `chezmoi apply --refresh-externals --dry-run --verbose` and apply when ready.

## Key Rules

- Always edit `.chezmoiexternal.toml.tmpl` (never `.chezmoiexternal.toml`)
- Standard `refreshPeriod` is `168h` (weekly)
- SSH for personal repos, HTTPS for public ones
- Don't apply — the user runs `chezmoi apply --refresh-externals` when ready
- See `AGENTS.md` for the overall external repositories reference
