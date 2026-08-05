# dot_local — ~/.local/

Machine-local data and configuration, mapped to `~/.local/` by chezmoi.

## Contents

| Path | Target | Description |
|------|--------|-------------|
| `bin/` | `~/.local/bin/` | Utility scripts: pqiv image viewer shim + annotation/crop/rotate wrappers |
| `share/applications/` | `~/.local/share/applications/` | Desktop entries: pqiv |
| `share/fcitx5/rime/` | `~/.local/share/fcitx5/rime/` | Rime IME customizations (default + rime_ice overrides) |
| `share/gentoo/repos/local/` | `~/.local/share/gentoo/repos/local/` | Local Gentoo ebuild repository (tieba-sign, ffmpeg-progress-yield, etc.) |
| `share/icons/` | `~/.local/share/icons/` | Default icon theme symlink |
| `share/kmonad/` | `~/.local/share/kmonad/` | Keyboard remapping configs for kmonad |

## Conventions

- `~/.local/` is for user-specific program data (XDG base directory spec)
- `share/` subdirectory follows XDG conventions for data files
- `bin/` contains executable wrapper scripts