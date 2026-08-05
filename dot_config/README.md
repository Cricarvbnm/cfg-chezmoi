# dot_config — ~/.config/

Application configuration files mapped to `~/.config/` by chezmoi. Each subdirectory corresponds to one application.

## Contents

| Directory/File | Target | Description |
|---|---|---|
| `btop/` | `~/.config/btop/` | System resource monitor: Catppuccin theme |
| `fontconfig/` | `~/.config/fontconfig/` | CJK font preferences (serif/sans/mono) |
| `fuzzel/` | `~/.config/fuzzel/` | Wayland app launcher: Catppuccin Macchiato theme |
| `git/` | `~/.config/git/` | Git client config: user info, aliases, Delta diff pager |
| `kitty/` | `~/.config/kitty/` | Kitty terminal: Catppuccin Macchiato theme |
| `hypr/` | `~/.config/hypr/` | Hyprland dynamic tiling Wayland compositor |
| `opencode/` | `~/.config/opencode/` | OpenCode AI agent config: agents, skills, plugins |
| `private_fcitx5/` | `~/.config/fcitx5/` | Fcitx5 input method config (restrictive perms) |
| `private_fish/` | `~/.config/fish/` | Fish shell config (restrictive perms) |
| `swaylock/` | `~/.config/swaylock/` | Screen locker: Catppuccin Macchiato theme |
| `swaync/` | `~/.config/swaync/` | Notification daemon: style + Catppuccin theme |
| `tieba-sign/` | `~/.config/tieba-sign/` | Baidu Tieba auto sign-in (GPG-encrypted config) |
| `uwsm/` | `~/.config/uwsm/` | Universal Wayland Session Manager |
| `waybar/` | `~/.config/waybar/` | Wayland status bar: system modules + Catppuccin theme |
| `nvim/` | `~/.config/nvim/` | **External**: LazyVim config (git-repo from Codeberg) |

## Conventions

- Source files are plain config files — no chezmoi templates unless machine-specific values needed
- `private_` prefix = restrictive permissions (600 for files, 700 for dirs)
- `nvim/` is not tracked directly; it's an `external git-repo` in `.chezmoiexternal.toml`
- External entries are defined in the repo root's `.chezmoiexternal.toml.tmpl`

> **关于 `opencode/AGENTS.md`**：它是被部署到 `~/.config/opencode/` 的 AI agent 行为守则（由 `.chezmoiignore` 显式 include），**不是**本仓库的目录说明文档。它的内容是指导 agent 在目标机器上的工作行为，修改它等于改 agent 行为，而非改仓库文档。
