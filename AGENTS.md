# AGENTS.md — Dotfiles Repository

This is a **chezmoi dotfile repository**, not a typical application. No build, test, or lint commands.

## Repo Type

- **Manager**: [chezmoi](https://www.chezmoi.io/) — dotfile manager
- **Configuration only**: application configs, not source code
- **Dual role**: config tracking + config change auditing (home dir has no git tracking)

## Path Mapping

**Source tree** (this repo) → **target tree** (your home directory):

| Source (editing here) | Target (deployed here) | Perms |
|--------|--------|-------|
| `dot_config/` | `~/.config/` | 755 |
| `dot_local/` | `~/.local/` | 755 |
| `dot_agents/` | `~/.agents/` | 755 |
| `texmf/` | `~/texmf/` | 755 |
| `private_dot_ssh/` | `~/.ssh/` | 700 |

Prefix `private_` = restrictive permissions (600 for files, 700 for directories).

## Conventions

### Source of Truth

**Filesystem data is the source of truth.** Documentation describes what exists — it does not prescribe what should exist. When documentation and data disagree, fix the documentation.

### README Policy

- Only **complex directories** warrant READMEs (currently: `dot_config/hypr/`)
- Simple config directories are self-documenting — no README needed
- `.chezmoiignore` excludes all `README.md` from target machines

### External Dependencies

Defined in `.chezmoiexternal.toml.tmpl`. Types: `git-repo`, `archive`, `file`. Standard `refreshPeriod` is `168h`.

### Run Scripts

chezmoi can execute scripts during `apply`. Scripts are discovered by `run_` prefix **anywhere** in the source tree — not in a dedicated directory.

| Prefix | When it runs |
|--------|-------------|
| `run_` | Every apply |
| `run_onchange_` | Only if content changed since last successful run |
| `run_once_` | Once per unique content (SHA256-hashed; re-runs if content changes even under a different name) |

Position modifiers: `before_` / `after_` control ordering relative to file updates.

Scripts are written to a temp file and executed — they need a `#!` shebang or be a binary. The working directory is the first existing parent in the destination tree. No executable bit needed in the source tree.

`.tmpl` suffix on a script makes it a template (access to `.chezmoi.*` variables, `include`, etc.). An empty/whitespace-only template result skips the script — useful for conditional disabling.

Scripts should be idempotent. Use them only when a configuration step cannot be expressed as a static file.

## Workflows

Common tasks have dedicated skills that enforce correct procedures:

| Task | Skill |
|------|-------|
| Add or modify config files | `chezmoi-add-config` |
| Add external dependencies | `chezmoi-add-external` |
| Sync documentation with data | `doc-sync` |
| Understand chezmoi templates | `chezmoi-templates` |

## Making Changes

1. Edit files in the **source tree** (`dot_*` directories)
2. Leave `chezmoi apply` to the user — the agent's job is source-tree editing only

## Key Constraints

- No application source code in this repo
- Never commit unencrypted secrets or credentials (GPG-encrypted files like `.asc` are fine)
- READMEs are repo-only, not deployed to target machines
- Run scripts should be idempotent
