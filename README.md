# Dotfiles

Personal configuration managed by [chezmoi](https://www.chezmoi.io/). Designed for Gentoo / Arch Linux — terminal, editor, Wayland compositor (niri), keyboard, fonts, Git, SSH, AI agent tooling, TeX, and input method.

## Table of Contents

- [Applications Configured](#applications-configured)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Architecture](#architecture)
  - [Path Mapping](#path-mapping)
  - [Directory Structure](#directory-structure)
  - [External Repositories](#external-repositories)
  - [Run Scripts](#run-scripts)
  - [Machine-Specific Configuration](#machine-specific-configuration)
- [What's Configured](#whats-configured)
- [License](#license)

## Applications Configured

| Application | Purpose | Config Location |
|---|---|---|
| [niri](https://github.com/YaLTeR/niri) | Scrollable-tiling Wayland compositor | `~/.config/niri/` |
| [waybar](https://github.com/Alexays/Waybar) | Status bar with system modules | `~/.config/waybar/` |
| [fuzzel](https://codeberg.org/dnkl/fuzzel) | Wayland app launcher | `~/.config/fuzzel/` |
| [swaylock](https://github.com/swaywm/swaylock) | Screen locker | `~/.config/swaylock/` |
| [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) | Notification daemon | `~/.config/swaync/` |
| [uwsm](https://github.com/Vladimir-csp/uwsm) | Wayland session manager | `~/.config/uwsm/` |
| [kitty](https://sw.kovidgoyal.net/kitty/) | Terminal emulator | `~/.config/kitty/` |
| [Neovim](https://neovim.io/) | Text editor (LazyVim) | `~/.config/nvim/` |
| [Git](https://git-scm.com/) | Version control | `~/.config/git/` |
| [Fish](https://fishshell.com/) | Friendly interactive shell | `~/.config/fish/` |
| [Fcitx5](https://fcitx-im.org/) | Input method framework + Rime | `~/.config/fcitx5/` |
| [kmonad](https://github.com/kmonad/kmonad) | Keyboard remapping | `~/.local/share/kmonad/` |
| [btop](https://github.com/aristocratos/btop) | System resource monitor | `~/.config/btop/` |
| [OpenCode](https://opencode.ai/) | AI coding agent | `~/.config/opencode/` |
| tieba-sign | Baidu Tieba auto sign-in | `~/.config/tieba-sign/` |
| Fontconfig | System font preferences | `~/.config/fontconfig/` |
| SSH | Client proxy | `~/.ssh/config` |
| TeX (texmf) | Local TeX tree + font cache | `~/texmf/` |

## Tech Stack

- **Manager**: [chezmoi](https://www.chezmoi.io/) — dotfile manager
- **Compositor**: [niri](https://github.com/YaLTeR/niri) — scrollable-tiling Wayland compositor
- **Theme**: [Catppuccin Macchiato](https://catppuccin.com/) (kitty, fuzzel, swaylock, swaync, waybar, btop)
- **Editor**: [LazyVim](https://www.lazyvim.org/) (personal fork on Codeberg)
- **Shell**: [Fish](https://fishshell.com/)
- **Input Method**: Fcitx5 + [Rime](https://rime.im/)
- **AI Tools**: OpenCode + antigravity-awesome-skills + Understand-Anything

## Prerequisites

A Linux system with a Wayland session. The following packages should be available (package names vary by distribution):

**Core:**
- [chezmoi](https://www.chezmoi.io/install/) — the dotfile manager itself
- `git`
- SSH key with access to [Codeberg](https://codeberg.org) (for external git repos)

**Desktop (Wayland):**
- `niri` — compositor
- `waybar` — status bar
- `fuzzel` — app launcher
- `swaylock` — screen locker
- `swaync` — notification daemon
- `uwsm` — session manager
- `swaybg` — wallpaper
- `swayidle` — idle management

**Terminal & Shell:**
- `kitty` — terminal emulator
- `fish` — shell
- `kmonad` — keyboard remapping

**Input:**
- `fcitx5` — input method framework

**Fonts:**
- `noto-cjk` (Noto Serif CJK SC, Noto Sans CJK SC)
- `fantasque-sans-mono` / `nerd-fonts` (FantasqueSansM Nerd Font)
- Catppuccin cursor theme

**Media & Hardware:**
- `pipewire`, `wireplumber` — audio
- `playerctl` — media key support
- `brightnessctl` — backlight control
- `network-manager-applet` — network tray
- `blueman-applet` — bluetooth tray
- `polkit-gnome` — authentication agent

**Clipboard:**
- `cliphist`, `wl-clipboard` (`wl-paste`, `wl-copy`)

**Editor & Documents:**
- `neovim` (LazyVim)
- `texlive` — LaTeX distribution
- `pandoc` — document conversion (needed by pandoc-latex-template external)

**AI Tools:**
- `pnpm` (for Understand-Anything plugin)

## Getting Started

### 1. Install chezmoi

Follow the [official installation guide](https://www.chezmoi.io/install/) for your distribution.

### 2. Initialize the dotfiles

```bash
# Clone and apply in one command
chezmoi init --apply Alechron/cfg-chezmoi
```

Or manually:

```bash
git clone https://codeberg.org/Alechron/cfg-chezmoi.git ~/.local/share/chezmoi
chezmoi apply
```

### 3. Refresh external repositories

External components (Neovim config, AI skills, knowledge vault) are managed via `.chezmoiexternal.toml`:

```bash
# Force refresh all externals
chezmoi apply --refresh-externals
```

### 4. Verify

```bash
# Check nothing is out of sync
chezmoi status

# Preview pending changes (should be empty)
chezmoi diff
```

## Architecture

chezmoi stores source files in `~/.local/share/chezmoi/` and applies them to their target locations in the home directory. This repository is the source state — the authoritative definition of what the target state should be.

### Path Mapping

| Source Directory | Target Path | Permissions |
|---|---|---|
| `dot_config/` | `~/.config/` | 755 |
| `dot_local/` | `~/.local/` | 755 |
| `dot_agents/` | `~/.agents/` | 755 |
| `private_dot_ssh/` | `~/.ssh/` | 700 |
| `texmf/` | `~/texmf/` | 755 |

Files prefixed with `private_` get restrictive permissions: 600 for files, 700 for directories.

### Directory Structure

```
~/.local/share/chezmoi/
├── dot_config/                          # → ~/.config/
│   ├── btop/
│   │   ├── btop.conf                    # System monitor config
│   │   └── themes/                      # Catppuccin theme
│   ├── fontconfig/conf.d/
│   │   └── 50-prefered-fonts.conf       # CJK font preferences
│   ├── fuzzel/
│   │   └── fuzzel.ini                   # App launcher + Catppuccin theme
│   ├── git/
│   │   ├── config.tmpl                  # Git aliases, user info (conditional)
│   │   └── delta.conf                   # Delta diff pager config
│   ├── kitty/
│   │   └── kitty.conf                   # Terminal + Catppuccin theme
│   ├── niri/
│   │   └── config.kdl                   # Wayland compositor keybindings + layout
│   ├── opencode/                        # OpenCode AI agent config
│   ├── private_fcitx5/
│   │   ├── private_config               # Fcitx5 config (restrictive perms)
│   │   └── private_profile              # Fcitx5 profile (restrictive perms)
│   ├── private_fish/
│   │   └── config.fish                  # Fish shell config (restrictive perms)
│   ├── swaylock/
│   │   └── config                       # Screen locker + Catppuccin theme
│   ├── swaync/
│   │   ├── config.json                  # Notification daemon config
│   │   └── style.css                    # Notification CSS + Catppuccin theme
│   ├── tieba-sign/
│   │   └── encrypted_config.toml.asc    # GPG-encrypted sign-in credentials
│   ├── uwsm/
│   │   └── default-id                   # Session manager compositor ID
│   ├── waybar/
│   │   ├── config.jsonc                 # Status bar modules
│   │   └── style.css                    # Catppuccin-themed bar
│   └── nvim/                            # → External: LazyVim (git-repo)
├── dot_local/share/kmonad/
│   ├── alechron-at.kbd                  # AT keyboard mapping
│   ├── alechron-usb.kbd                 # USB keyboard mapping
│   └── README.md
├── dot_agents/
│   ├── symlink_all-skills              # → antigravity-awesome-skills
│   ├── exact_skills/                    # Exact symlinks to skill defs
│   └── Understand-Anything/             # → External: archive
├── private_dot_ssh/
│   └── config                           # SSH proxy via localhost:7890
├── texmf/
│   ├── run_once_texhash.sh              # TeX font cache refresh
│   └── tex/latex/                       # Local TeX packages
├── .chezmoiexternal.toml                # External dependency definitions
├── .chezmoiignore                       # Selective deployment rules (template)
└── README.md
```

### External Repositories

Defined in `.chezmoiexternal.toml`. These are downloaded separately and kept in sync via `chezmoi apply --refresh-externals`.

| Target Path | Type | Source | Refresh |
|---|---|---|---|
| `~/.config/nvim` | `git-repo` | `ssh://git@codeberg.org/Alechron/cfg-lazyvim.git` | 168h |
| `~/knowledge` | `git-repo` | `ssh://git@codeberg.org/Alechron/knowledge-vault.git` | 168h (personal only) |
| `~/.local/share/fcitx5/rime` | `archive` | GitHub: iDvel/rime-ice | 168h |
| `~/.local/share/fcitx5/rime/cn_dicts/moegirl.dict.yaml` | `file` | GitHub: outloudvi/mw2fcitx | 168h |
| `~/.agents/Understand-Anything` | `archive` | GitHub: Lum1104/Understand-Anything | 168h |
| `~/.agents/antigravity-awesome-skills` | `archive` | GitHub: sickn33/antigravity-awesome-skills | 168h |
| `~/Templates/pandoc/pandoc-latex-template` | `archive` | GitHub: Wandmalfarbe/pandoc-latex-template | 168h |
| `~/Projects/ppt-master` | `archive` | GitHub: hugohe3/ppt-master | 168h |

### Run Scripts

chezmoi can execute scripts during apply. This repo uses `run_once_` scripts (execute once, then skip):

| Script | Purpose |
|---|---|
| `texmf/run_once_texhash.sh` | Runs `texhash ~/texmf` to index local TeX packages |
| `dot_agents/.../run_once_pnpm_sync.sh` | Runs `pnpm install` in Understand-Anything plugin |

### Machine-Specific Configuration

Feature flags in `~/.config/chezmoi/chezmoi.toml` control selective deployment via three mechanisms:

| Flag | Purpose | Controlled configs |
|------|---------|-------------------|
| `personal` | Personal identity + knowledge | git `[user]`, knowledge vault, opencode/AGENTS.md |
| `desktop` | Daily desktop machine | tieba-sign (requires `personal && desktop`) |
| `proxy` | Network proxy available | SSH proxy config |
| `custom_de` | Custom desktop environment | niri, waybar, fuzzel, swaylock, swaync, uwsm |

To opt in on a machine:

```toml
# ~/.config/chezmoi/chezmoi.toml
[data]
    personal  = true
    desktop   = true
    proxy     = true
    custom_de = true
```

**`.chezmoiignore` template** — ignores entire files when their flag is false (`.custom_de` controls 8 niri companion files).

**`.tmpl` conditional** — wraps granular sections (git `[user]`).

**`.chezmoiexternal.toml` template** — conditional external repositories (knowledge vault).

See [chezmoi template data](https://www.chezmoi.io/user-guide/templating/#template-data) for details.

## What's Configured

Detailed documentation lives in each config directory. Click through for specifics.

### Desktop (Wayland)

| App | Config | Docs |
|-----|--------|------|
| niri | `~/.config/niri/config.kdl` | [README](dot_config/niri/README.md) |
| waybar | `~/.config/waybar/` | [README](dot_config/waybar/README.md) |
| fuzzel | `~/.config/fuzzel/fuzzel.ini` | [README](dot_config/fuzzel/README.md) |
| swaylock | `~/.config/swaylock/config` | [README](dot_config/swaylock/README.md) |
| SwayNC | `~/.config/swaync/` | [README](dot_config/swaync/README.md) |
| uwsm | `~/.config/uwsm/default-id` | [README](dot_config/uwsm/README.md) |

### Terminal & Shell

| App | Config | Docs |
|-----|--------|------|
| kitty | `~/.config/kitty/kitty.conf` | [README](dot_config/kitty/README.md) |
| fish | `~/.config/fish/config.fish` | [README](dot_config/private_fish/README.md) |

### Editor & System

| App | Config | Docs |
|-----|--------|------|
| Neovim | `~/.config/nvim/` (external) | [LazyVim](https://www.lazyvim.org/) |
| Git | `~/.config/git/` | [README](dot_config/git/README.md) |
| btop | `~/.config/btop/btop.conf` | [README](dot_config/btop/README.md) |

### Input

| App | Config | Docs |
|-----|--------|------|
| Fcitx5 + Rime | `~/.config/fcitx5/` | [README](dot_config/private_fcitx5/README.md) |
| kmonad | `~/.local/share/kmonad/` | [README](dot_local/share/kmonad/README.md) |
| Fontconfig | `~/.config/fontconfig/` | [README](dot_config/fontconfig/README.md) |

### AI & Automation

| App | Config | Docs |
|-----|--------|------|
| OpenCode | `~/.config/opencode/` | [README](dot_config/opencode/README.md) |
| Agent Skills | `~/.agents/` | [README](dot_agents/README.md) |
| tieba-sign | `~/.config/tieba-sign/` | [README](dot_config/tieba-sign/README.md) |

### Documents

| App | Config | Docs |
|-----|--------|------|
| TeX (texmf) | `~/texmf/` | [README](texmf/README.md) |
| pandoc template | `~/Templates/pandoc/` (external) | [Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template) |
| ppt-master | `~/Projects/ppt-master/` (external) | [ppt-master](https://github.com/hugohe3/ppt-master) |
| SSH | `~/.ssh/config` | [README](private_dot_ssh/README.md) |
| knowledge vault | `~/knowledge/` (external) | Obsidian vault

## License

Personal configuration. Files may be used as templates for your own dotfiles.
