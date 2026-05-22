# AGENTS.md - Dotfiles Repository

This is a **chezmoi dotfile repository**, not a typical application. There are no build or test commands.

## Repo Type

- **Manager**: [chezmoi](https://www.chezmoi.io/) - dotfile manager
- **No scripts**: No Makefile, no build/test/lint commands
- **Configuration only**: Application configs, not source code

## Important Conventions

### Path Mapping (chezmoi-specific)

- `dot_config/` → `~/.config/` (user config)
- `dot_local/` → `~/.local/` (local/machine-specific)
- `private_dot_ssh/` → `~/.ssh/` (private, perms 700)
- Prefix `private_` = restrictive permissions (600 or 700)

### External Repositories

Managed via `.chezmoiexternal.toml`:

- `.config/nvim` → LazyVim config from codeberg (personal fork)
- `.agents/antigravity-awesome-skills` → AI skills from GitHub
- `模板/pandoc/pandoc-latex-template` → Pandoc LaTeX template from GitHub

### README Files

`.chezmoiignore` excludes `README.md` from target machines. READMEs are for documentation only.

## Agent Workflows

### Read First

- Root `README.md` for structure overview
- Subdirectory READMEs for feature details

### Making Changes

1. Edit files in source state (`dot_*` directories)
2. Test with `chezmoi diff` before applying
3. Apply with `chezmoi apply` (**Ask for applying**)

### Adding New Configurations

- Create new files in appropriate `dot_*` directory
- Use `private_` prefix for sensitive files requiring restricted permissions

## Key Constraints

- No executable code in this repo
- No CI/CD workflows
- Personal configuration - not intended for collaboration
- Some files are references to external git repos (defined in `.chezmoiexternal.toml`)

