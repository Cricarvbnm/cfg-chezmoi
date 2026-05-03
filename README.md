# Dotfiles

Managed via [chezmoi](https://www.chezmoi.io/).

## Applications

- [kitty](https://sw.kovidgoyal.net/kitty/) (terminal)
- [git](https://git-scm.com/) (version control)
- [KDE Plasma](https://kde.org/plasma-desktop) (global shortcuts)
- [kmonad](https://github.com/kmonad/kmonad) (keyboard mapping)
- [dot_agents](https://github.com/sickn33/antigravity-awesome-skills) (AI skills)
- SSH (proxy)

## Path Mapping

dot_config/ → \~/.config/
dot_local/ → \~/.local/
private_dot_ssh/ → \~/.ssh/ (Only the user can read)

## Structure

```
.
├── dot_config/
│   ├── git/
│   │   ├── config       # Git configuration
│   │   └── delta.conf  # Delta diff pager
│   ├── kitty/
│   │   └── kitty.conf  # Terminal config
│   ├── kglobalshortcutsrc  # KDE global shortcuts
│   └── nvim/              # External: LazyVim
├── dot_local/share/kmonad/
│   ├── alechron-at.kbd
│   └── alechron-usb.kbd
├── dot_agents/skills/  # AI agent skills
├── private_dot_ssh/
│   └── config         # SSH client config
└── .chezmoiexternal.toml
```

See README.md in most directories for details.

## License

This is a personal configuration. Files may be used as templates for your own dotfiles.
