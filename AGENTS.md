# AGENTS.md - Dotfiles Repository

This is a **chezmoi dotfile repository**, not a typical application. There are no build or test commands.

## Repo Type

- **Manager**: [chezmoi](https://www.chezmoi.io/) - dotfile manager
- **No build/test/lint**: No Makefile, no CI/CD, no test suites
- **Configuration only**: Application configs, not source code
- **Run scripts**: chezmoi `run_once_` scripts for post-apply setup (TeX cache, pnpm install)

## Important Conventions

### Path Mapping (chezmoi-specific)

| Source | Target | Perms |
|--------|--------|-------|
| `dot_config/` | `~/.config/` | 755 |
| `dot_local/` | `~/.local/` | 755 |
| `dot_agents/` | `~/.agents/` | 755 |
| `texmf/` | `~/texmf/` | 755 |
| `private_dot_ssh/` | `~/.ssh/` | 700 |

Prefix `private_` = restrictive permissions (600 for files, 700 for directories).

### External Repositories

Managed via `.chezmoiexternal.toml`:

| Target | Type | Source | Refresh |
|--------|------|--------|---------|
| `~/.config/nvim` | git-repo | LazyVim config from Codeberg (personal fork) | 168h |
| `~/knowledge` | git-repo | Obsidian knowledge vault from Codeberg | 168h |
| `~/.agents/Understand-Anything` | archive | GitHub: Lum1104/Understand-Anything | 168h |
| `~/.agents/antigravity-awesome-skills` | archive | GitHub: sickn33/antigravity-awesome-skills | 168h |
| `~/Templates/pandoc/pandoc-latex-template` | archive | GitHub: Wandmalfarbe/pandoc-latex-template | 168h |
| `~/Projects/ppt-master` | archive | GitHub: hugohe3/ppt-master | 168h |

### Run Scripts

chezmoi scripts prefixed `run_` execute on every apply; `run_once_` scripts execute only once. This repo uses `run_once_` wherever possible.

| Script | Type | Purpose |
|--------|------|---------|
| `texmf/run_once_texhash.sh` | run_once | Index local TeX packages |
| `dot_agents/.../run_once_pnpm_sync.sh` | run_once | Install pnpm deps in Understand-Anything |

### README Files

`.chezmoiignore` excludes all `README.md` from target machines (except `.config/opencode/` entries). READMEs are for documentation only.

## Agent Workflows

### Read First

- Root `README.md` for comprehensive overview and troubleshooting
- Each subdirectory has a `README.md` describing that directory's contents:
  - `dot_config/README.md` — per-app config layout
  - `dot_agents/README.md` — skill symlink organization
  - `dot_local/README.md` — local machine data
  - `texmf/README.md` — local TeX tree
  - `private_dot_ssh/README.md` — SSH proxy setup
  - `dot_local/share/kmonad/README.md` — keyboard configs
- `dot_config/opencode/AGENTS.md` is a special case — deployed to `~/.config/opencode/` as AI agent behavior rules, not a repo directory doc

### Making Changes

1. Edit files in source state (`dot_*` directories)
2. Preview with `chezmoi diff`
3. Apply with `chezmoi apply` (**Ask before applying**)

### Adding New Configurations

- Create new files in appropriate `dot_*` directory
- Use `private_` prefix for sensitive files requiring restricted permissions
- For machine-specific content, use chezmoi templates (`{{ if eq .chezmoi.hostname "..." }}`)

### Adding New External Dependencies

Add entries to `.chezmoiexternal.toml`:
- `git-repo` for full Git repositories
- `archive` for downloaded/extracted tarballs
- Set `refreshPeriod` (168h = weekly)

## Key Constraints

- No application source code in this repo
- No CI/CD workflows
- Personal configuration — not intended for collaboration
- External git repos and archives are defined in `.chezmoiexternal.toml` and managed separately
- Run scripts are idempotent: safe to re-run, use `run_once_` to avoid redundant execution
