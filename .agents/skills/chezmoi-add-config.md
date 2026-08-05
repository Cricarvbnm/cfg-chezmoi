---
name: chezmoi-add-config
description: Add or modify configuration files in the chezmoi dotfiles repository. Use when asked to add a new config file, copy a config from the target machine into the repo, or modify an existing tracked configuration.
---

# chezmoi-add-config

Add or modify configuration files in the source tree of this chezmoi dotfiles repository. The agent's job is to create or edit files — applying changes to the target machine is the user's responsibility.

## When to Use

- Adding a new configuration file from the target machine into the repo
- Creating a new config file to be deployed
- Modifying an existing tracked configuration

## Workflow

### 1. Determine Source Path

Identify the target path on the machine (e.g., `~/.config/foo/bar.conf`), then map to the source directory:

| Target | Source |
|--------|--------|
| `~/.config/` | `dot_config/` |
| `~/.local/` | `dot_local/` |
| `~/.agents/` | `dot_agents/` |
| `~/.ssh/` | `private_dot_ssh/` |
| `~/texmf/` | `texmf/` |

### 2. Create or Edit Files

- Place files in the correct source directory
- Use `private_` prefix for sensitive files requiring restricted permissions (600 for files, 700 for dirs)
- If the new config should be conditionally deployed, add rules to `.chezmoiignore`

### 3. Update Documentation (if needed)

Only update documentation for **complex directories** that have READMEs. Currently this means `dot_config/hypr/README.md`. Simple config directories are self-documenting and do not need READMEs.

If the change introduces a new piece of information worth documenting in the complex directory's README, update it.

### 4. Inform the User

Tell the user what files were created or modified. The user decides when to `chezmoi apply`.

## Key Rules

- **Source tree only** — edit files in `dot_*` directories, don't touch the target machine's configs directly
- **Don't apply** — leave `chezmoi apply` to the user
- **Respect permissions** — use `private_` prefix for sensitive files
