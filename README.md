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
- [What's Configured](#whats-configured)
  - [Git](#git)
  - [Kitty Terminal](#kitty-terminal)
  - [Fonts (Fontconfig)](#fonts-fontconfig)
  - [kmonad Keyboard Remapping](#kmonad-keyboard-remapping)
  - [SSH](#ssh)
  - [Neovim](#neovim)
  - [OpenCode AI Agent](#opencode-ai-agent)
  - [AI Agent Skills](#ai-agent-skills)
  - [niri Compositor](#niri-compositor)
  - [Wayland Desktop Companions](#wayland-desktop-companions)
  - [Fish Shell](#fish-shell)
  - [Fcitx5 Input Method](#fcitx5-input-method)
  - [btop System Monitor](#btop-system-monitor)
  - [tieba-sign](#tieba-sign)
  - [TeX (texmf)](#tex-texmf)
  - [External Archives](#external-archives)
- [Daily Workflow](#daily-workflow)
- [Troubleshooting](#troubleshooting)
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
- **OS**: Gentoo Linux with niri (Wayland)
- **Theme**: [Catppuccin Macchiato](https://catppuccin.com/) (kitty, fuzzel, swaylock, swaync, waybar, btop)
- **Editor**: [LazyVim](https://www.lazyvim.org/) (personal fork on Codeberg)
- **Shell**: [Fish](https://fishshell.com/)
- **Input Method**: Fcitx5 + [Rime](https://rime.im/)
- **AI Tools**: OpenCode + antigravity-awesome-skills + Understand-Anything

## Prerequisites

Gentoo / Arch Linux with a minimal base install. The following should be available or will be installed separately:

- [chezmoi](https://www.chezmoi.io/install/) (the dotfile manager itself)
- SSH key with access to [Codeberg](https://codeberg.org) (for external git repos)
- `git`, `kitty`, `neovim`, `kmonad`, `texlive`

Optional but used by external components:
- `pnpm` (for Understand-Anything plugin)
- `pandoc` (for document conversion)
- `texhash` (part of texlive)

## Getting Started

### 1. Install chezmoi

```bash
# On Gentoo
sudo emerge app-admin/chezmoi

# On Arch Linux
sudo pacman -S chezmoi
```

### 2. Initialize the dotfiles

```bash
# Clone and apply in one command
# FIXME: Replace with your actual Codeberg repo path
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
│   │   ├── config                       # Git aliases, user info
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
├── .chezmoiignore                       # Files excluded from target
└── README.md
```

### External Repositories

Defined in `.chezmoiexternal.toml`. These are downloaded separately and kept in sync via `chezmoi apply --refresh-externals`.

| Target Path | Type | Source | Refresh |
|---|---|---|---|
| `~/.config/nvim` | `git-repo` | `ssh://git@codeberg.org/Alechron/cfg-lazyvim.git` | 168h |
| `~/knowledge` | `git-repo` | `ssh://git@codeberg.org/Alechron/knowledge-vault.git` | 168h |
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

## What's Configured

### Git

**File**: `~/.config/git/config` + `~/.config/git/delta.conf`

- Default branch: `main`
- User: Alec &lt;alechron@outlook.com&gt;
- Short aliases: `a` (add), `aa` (add --all), `s` (status --short --branch), `sl` (status), `c` (commit), `ca` (commit --all), `cu` (commit --amend)
- Uses [Delta](https://github.com/dandavison/delta) for syntax-highlighted diffs

### Kitty Terminal

**File**: `~/.config/kitty/kitty.conf`

- [Catppuccin Macchiato](https://catppuccin.com/) color theme
- Theme loaded via `include current-theme.conf` (managed by the kitty [themes kitten](https://sw.kovidgoyal.net/kitty/kittens/themes/))
- All other settings use kitty defaults

### Fonts (Fontconfig)

**File**: `~/.config/fontconfig/conf.d/50-prefered-fonts.conf`

Sets preferred fonts for CJK compatibility:

| Category | Preferred Font |
|---|---|
| Serif | Noto Serif CJK SC |
| Sans-serif | Noto Sans CJK SC |
| Monospace | Sarasa Fixed SC, fallback FantasqueSansM Nerd Font |

### kmonad Keyboard Remapping

**Directory**: `~/.local/share/kmonad/`

Two keyboard configurations for [kmonad](https://github.com/kmonad/kmonad):

- `alechron-at.kbd` — AT-translated keyboard mapping (laptop built-in)
- `alechron-usb.kbd` — USB keyboard mapping (specific port)

A systemd service reads configs from `/etc/kmonad/` (symlink to this directory).

### SSH

**File**: `~/.ssh/config`

All non-local connections are proxied through `localhost:7890`:

```
Host !*.local *
    ProxyCommand nc -Xconnect -x localhost:7890 %h %p
```

### Neovim

**Directory**: `~/.config/nvim/` (external)

Personal fork of [LazyVim](https://www.lazyvim.org/) hosted on Codeberg. Includes custom plugins, keybindings, and language support. Managed as a `git-repo` external — pull updates via `chezmoi apply --refresh-externals`.

### OpenCode AI Agent

**Directory**: `~/.config/opencode/`

Configuration for the [OpenCode](https://opencode.ai/) AI coding agent:

- `opencode.json` — Core agent configuration
- `oh-my-opencode-slim.json` — Plugin configuration
- `tui.json` — Terminal UI preferences
- `AGENTS.md` — Agent instructions (explicitly included via `.chezmoiignore`)
- `package.json` / `package-lock.json` — Agent plugin dependencies

### AI Agent Skills

**Directory**: `~/.agents/`

Two layers of AI skills:

1. **antigravity-awesome-skills** (external archive) — Base skill collection from GitHub. Includes skills for Python, Django, FastAPI, Go, Git, documentation, testing, presentations, and more.

2. **exact_skills/** — Per-skill symlinks that selectively enable individual skills from the collection. Currently includes agent-browser, async-python-patterns, bash-linux, and others.

3. **Understand-Anything** (external archive) — Plugin for codebase understanding and knowledge graph generation.

### niri Compositor

**File**: `~/.config/niri/config.kdl`

Scrollable-tiling Wayland compositor with:
- Input device setup (keyboard, touchpad, mouse, trackpoint)
- Per-output mode and scaling (`eDP-1` @ 1920x1080@120Hz 1.5x, `HDMI-A-3` @ 2.5x)
- Layout with gaps, focus ring, borders, and shadows
- Full keybinding suite: workspace navigation, window management, column operations
- Spawn-at-startup: swaync, swaybg, waybar, fcitx5, PipeWire, network/bluetooth applets
- Screenshot integration, clipboard history via cliphist, Catppuccin cursor theme

### Wayland Desktop Companions

**fuzzel** (`~/.config/fuzzel/fuzzel.ini`): Catppuccin Macchiato-themed app launcher, launches via `Mod+D`.

**waybar** (`~/.config/waybar/`): Top bar with niri workspace switcher (kanji icons), clock with calendar, system tray, privacy indicator, idle inhibitor, network, pulseaudio, backlight, CPU temp, CPU/memory usage, power profiles, UPower devices, and battery with charging states. Catppuccin-themed via `style.css`.

**swaylock** (`~/.config/swaylock/config`): Screen locker with Catppuccin Macchiato colors, clock display, blur effect, and vignette. Triggered by `swayidle` after 5min idle.

**SwayNC** (`~/.config/swaync/`): Notification daemon with Catppuccin Macchiato themed CSS. Minimal config, `Mod+N` toggles notification panel.

**uwsm** (`~/.config/uwsm/default-id`): Universal Wayland Session Manager, set to launch niri.

### Fish Shell

**File**: `~/.config/fish/config.fish` (restrictive permissions via `private_` prefix)

Fish shell configuration with custom aliases and environment setup.

### Fcitx5 Input Method

**Directory**: `~/.config/fcitx5/` (restrictive permissions via `private_` prefix)

Fcitx5 configuration with [Rime](https://rime.im/) engine. The Rime data directory (`~/.local/share/fcitx5/rime`) is managed externally:
- **rime-ice** — Rime input schema collection (archive from GitHub)
- **moegirl.dict.yaml** — Moegirl wiki dictionary (file from GitHub)

### btop System Monitor

**File**: `~/.config/btop/btop.conf` + themes

Terminal system resource monitor (CPU, memory, network, processes) with Catppuccin Macchiato theme. Launchable from waybar CPU/memory module click.

### tieba-sign

**File**: `~/.config/tieba-sign/encrypted_config.toml.asc`

Baidu Tieba automatic sign-in tool. Configuration file is GPG-encrypted at rest. Decryption requires the GPG key `542E03119CACFA00`.

### TeX (texmf)

**Directory**: `~/texmf/`

Local TeX tree for custom LaTeX packages and styles. The `run_once_texhash.sh` script refreshes the TeX filename database on first apply.

### External Archives

Three additional external archives provide supplementary tools:

- `~/Templates/pandoc/pandoc-latex-template` — [Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template) Pandoc LaTeX template for PDF generation
- `~/Projects/ppt-master` — Python PowerPoint generation toolkit
- `~/knowledge` — Obsidian knowledge vault (personal notes, coding standards, development practices)

## Daily Workflow

```bash
# Check what's changed
chezmoi status

# Preview changes before applying
chezmoi diff

# Apply changes (with confirmation on interactive mode)
chezmoi apply

# Add a new config file
chezmoi add ~/.config/some-app/config.toml

# Edit a managed file
chezmoi edit ~/.config/some-app/config.toml

# Refresh external sources (e.g., after a week)
chezmoi apply --refresh-externals
```

**Adding new configurations:**

1. Create the file directly in the `dot_*` source directories
2. Use `private_` prefix for sensitive files (SSH keys, tokens)
3. Preview with `chezmoi diff`
4. Apply with `chezmoi apply`

**Machine-specific files:**

For files that differ between machines, use chezmoi templates (`{{ if eq .chezmoi.hostname "work" }}...`) or separate branches.

## Troubleshooting

### chezmoi apply shows "R" (run) status persistently

This is normal for `run_` scripts — they execute on every apply. This repo uses `run_once_` scripts that only execute the first time. If you see `R` for `pnpm_sync.sh`, it was already converted to `run_once_`.

### External git repos won't clone

Make sure your SSH key has access to `codeberg.org`:

```bash
ssh -T git@codeberg.org
```

Should reply: `Hi Alechron! You've successfully authenticated...`

### Neovim not working after apply

The Neovim config is an external `git-repo`. Force a refresh:

```bash
chezmoi apply --refresh-externals
```

Then run `nvim` — LazyVim will bootstrap its plugins on first launch.

### kmonad service not picking up config changes

The systemd service reads from `/etc/kmonad/` which should be symlinked to `~/.local/share/kmonad/`. Restart the service after changes:

```bash
sudo systemctl restart kmonad
```

### TeX packages not found

Run the texhash script:

```bash
texhash ~/texmf
```

Or re-apply chezmoi to trigger `run_once_texhash.sh`.

## License

Personal configuration. Files may be used as templates for your own dotfiles.
