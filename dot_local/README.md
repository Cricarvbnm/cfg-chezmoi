# dot_local — ~/.local/

Machine-local data and configuration, mapped to `~/.local/` by chezmoi.

## Contents

| Path | Target | Description |
|------|--------|-------------|
| `share/kmonad/` | `~/.local/share/kmonad/` | Keyboard remapping configs for kmonad |

## Conventions

- `~/.local/` is for user-specific program data (XDG base directory spec)
- `share/` subdirectory follows XDG conventions for data files
- Currently only contains kmonad keyboard configs; may expand to other local state as needed
