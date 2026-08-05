# Dotfiles

Personal configuration managed by [chezmoi](https://www.chezmoi.io/). Designed for Gentoo / Arch Linux — terminal, editor, Wayland compositor (hyprland), keyboard, fonts, Git, SSH, AI agent tooling, TeX, and input method.

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
| [Hyprland](https://hyprland.org/) | Dynamic tiling Wayland compositor | `~/.config/hypr/` |
| [waybar](https://github.com/Alexays/Waybar) | Status bar with system modules | `~/.config/waybar/` |
| [fuzzel](https://codeberg.org/dnkl/fuzzel) | Wayland app launcher | `~/.config/fuzzel/` |
| [swaylock](https://github.com/swaywm/swaylock) | Screen locker | `~/.config/swaylock/` |
| [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) | Notification daemon | `~/.config/swaync/` |
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
- **Compositor**: [Hyprland](https://hyprland.org/) — dynamic tiling Wayland compositor
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
- `hyprland` — compositor
- `waybar` — status bar
- `fuzzel` — app launcher
- `swaylock` — screen locker
- `swaync` — notification daemon
- `uwsm` — session manager
- `swaybg` — wallpaper

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

External components (Neovim config, AI skills, knowledge vault) are managed via `.chezmoiexternal.toml.tmpl`:

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
│   ├── fontconfig/
│   │   └── fonts.conf                   # CJK font preferences
│   ├── fuzzel/
│   │   └── fuzzel.ini                   # App launcher + Catppuccin theme
│   ├── git/
│   │   ├── config.tmpl                  # Git aliases, user info (conditional)
│   │   └── delta.conf                   # Delta diff pager config
│   ├── kitty/
│   │   └── kitty.conf                   # Terminal + Catppuccin theme
│   ├── hypr/
│   │   ├── hyprland.lua                 # Main entry point
│   │   ├── autostart.lua                # Startup applications
│   │   ├── input.lua                    # Input device settings
│   │   ├── keybindings.lua             # Key bindings
│   │   ├── monitors.lua                # Monitor configuration
│   │   ├── rules.lua                   # Window rules
│   │   ├── style.lua                   # Visual styling
│   │   └── zoom.lua                    # Zoom/scale support
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
│   ├── waybar/
│   │   ├── config.hyprland.jsonc        # Status bar modules
│   │   └── style.css                    # Catppuccin-themed bar
│   └── nvim/                            # → External: LazyVim (git-repo)
├── dot_local/
│   ├── bin/                              # Utility scripts (pqiv image viewer wrappers)
│   └── share/
│       ├── applications/
│       │   └── pqiv.desktop              # pqiv desktop entry
│       ├── fcitx5/rime/                  # Rime IME custom configs
│       │   ├── default.custom.yaml
│       │   └── rime_ice.custom.yaml
│       ├── gentoo/repos/local/           # Local Gentoo ebuilds
│       ├── icons/
│       │   └── symlink_default           # Default icon theme symlink
│       └── kmonad/
│           ├── alechron-at.kbd
│           └── alechron-usb.kbd
├── dot_agents/
│   ├── symlink_all-skills              # → antigravity-awesome-skills
│   ├── exact_skills/                    # Exact symlinks to skill defs
│   └── Understand-Anything/             # → External: archive
├── private_dot_ssh/
│   └── config                           # SSH proxy via localhost:7890
├── texmf/
│   ├── run_once_texhash.sh              # TeX font cache refresh
│   └── tex/latex/                       # Local TeX packages
├── .chezmoiexternal.toml.tmpl           # External dependency definitions
├── .chezmoiignore                       # Selective deployment rules (template)
└── README.md
```

### External Repositories

Defined in `.chezmoiexternal.toml.tmpl`. These are downloaded separately and kept in sync via `chezmoi apply --refresh-externals`.

| Target Path | Type | Source | Refresh |
|---|---|---|---|
| `~/.config/nvim` | `git-repo` | `ssh://git@codeberg.org/Alechron/cfg-lazyvim.git` | 168h |
| `~/knowledge` | `git-repo` | `ssh://git@codeberg.org/Alechron/knowledge-vault.git` | 168h (personal only) |
| `~/.local/share/fcitx5/rime` | `archive` | GitHub: iDvel/rime-ice | 168h |
| `~/.local/share/fcitx5/rime/cn_dicts/moegirl.dict.yaml` | `file` | GitHub: outloudvi/mw2fcitx | 168h |
| `~/.agents/Understand-Anything` | `archive` | GitHub: Lum1104/Understand-Anything (plugin subdir only) | 168h |
| `~/.agents/antigravity-awesome-skills` | `archive` | GitHub: sickn33/antigravity-awesome-skills | 168h |
| `~/Templates/pandoc/pandoc-latex-template` | `archive` | GitHub: Wandmalfarbe/pandoc-latex-template | 168h |
| `~/Projects/ppt-master` | `archive` | GitHub: hugohe3/ppt-master | 168h |
| `~/.config/hypr/docs/xkbcommon-keysyms.h` | `file` | GitHub: xkbcommon/libxkbcommon | 168h |

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
| `custom_de` | Custom desktop environment | hyprland, waybar, fuzzel, swaylock, swaync |

To opt in on a machine:

```toml
# ~/.config/chezmoi/chezmoi.toml
[data]
    personal  = true
    desktop   = true
    proxy     = true
    custom_de = true
```

**`.chezmoiignore` template** — ignores entire files when their flag is false (`.custom_de` controls hyprland and its companion files).

**`.tmpl` conditional** — wraps granular sections (git `[user]`).

**`.chezmoiexternal.toml.tmpl` template** — conditional external repositories (knowledge vault).

See [chezmoi template data](https://www.chezmoi.io/user-guide/templating/#template-data) for details.

## What's Configured

Most configurations are self-documenting (config files speak for themselves). Complex or non-obvious configurations are documented below.

### Desktop (Wayland)

| App | Config |
|-----|--------|
| [Hyprland](https://hyprland.org/) | `~/.config/hypr/` — [README](dot_config/hypr/README.md) |
| waybar | `~/.config/waybar/` |
| fuzzel | `~/.config/fuzzel/` |
| swaylock | `~/.config/swaylock/` |
| SwayNC | `~/.config/swaync/` |

### Terminal & Shell

| App | Config |
|-----|--------|
| kitty | `~/.config/kitty/` |
| fish | `~/.config/fish/` |

### Editor & System

| App | Config |
|-----|--------|
| Neovim | `~/.config/nvim/` (external: [LazyVim](https://www.lazyvim.org/)) |
| Git | `~/.config/git/` |
| btop | `~/.config/btop/` |

### Input

| App | Config |
|-----|--------|
| Fcitx5 + Rime | `~/.config/fcitx5/` |
| kmonad | `~/.local/share/kmonad/` |
| Fontconfig | `~/.config/fontconfig/` |

### AI & Automation

| App | Config |
|-----|--------|
| OpenCode | `~/.config/opencode/` |
| Agent Skills | `~/.agents/` |
| tieba-sign | `~/.config/tieba-sign/` |

### Documents

| App | Config |
|-----|--------|
| TeX (texmf) | `~/texmf/` |
| pandoc template | `~/Templates/pandoc/` (external: [Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template)) |
| ppt-master | `~/Projects/ppt-master/` (external) |
| SSH | `~/.ssh/` |
| knowledge vault | `~/knowledge/` (external)

## License

Personal configuration. Files may be used as templates for your own dotfiles.
