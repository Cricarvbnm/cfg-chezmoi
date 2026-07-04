# Git — ~/.config/git/

Git client configuration: user identity, command aliases, and diff pager.

## Contents

| File | Purpose |
|------|---------|
| `config.tmpl` | Git user info (conditional), init settings, command aliases |
| `delta.conf` | [Delta](https://github.com/dandavison/delta) diff pager config (included via `[include]`) |

## Configuration

### git/config.tmpl

Uses chezmoi template to deploy `[user]` section only on personal machines (when `data.personal = true` in `chezmoi.toml`).

- **Default branch**: `main`
- **User** (personal only): Alec (`alechron@outlook.com`)
- **Aliases**:
  - `a` → `add`, `aa` → `add --all`
  - `s` → `status --short --branch`, `sl` → `status`
  - `c` → `commit`, `ca` → `commit --all`, `cu` → `commit --amend`

### delta.conf

Enabled as global pager (`core.pager = delta`) and interactive diff filter (`interactive.diffFilter = delta --color-only`).

## Conventions

- Two-file split: `config` for Git-native settings, `delta.conf` for pager config — keeps concerns separated
- `delta.conf` is included via `[include] path = delta.conf` in the main config
