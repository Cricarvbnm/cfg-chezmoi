# Hyprland — ~/.config/hypr/

Dynamic tiling Wayland compositor with Catppuccin Macchiato theme.

## Architecture

Modular Lua configuration — `hyprland.lua` is the entry point that `require()`s each module.

### Modules

| File | Purpose |
|------|---------|
| `hyprland.lua` | Entry point, module orchestration |
| `monitors.lua` | Display layout: scale, position, workspace mapping |
| `autostart.lua` | Startup applications (polkit, nm-applet, blueman, etc.) |
| `input.lua` | Keyboard layout, repeat rate, touchpad settings |
| `style.lua` | Window decorations, gaps, rounding, opacity, colors |
| `keybindings.lua` | All key bindings (launchers, windows, workspaces, media, screenshot) |
| `rules.lua` | Per-application window rules (float, size, workspace) |
| `zoom.lua` | Temporary zoom/scale via keybind (accessibility) |
| `reference.lua` | Keycode and modifier name constants |
| `dot_luarc.json` | Lua Language Server configuration |

## Theme

Catppuccin Macchiato color palette applied to window decorations, gaps, rounding, and opacity.

## Key Bindings

See `keybindings.lua` for the full list. Commonly:
- `Super + Return` — kitty
- `Super + D` — fuzzel app launcher
- `Super + Q` — close window
- `Super + V` — toggle floating
- `Super + 1-9` — switch workspace

## References

- [Hyprland Wiki](https://wiki.hypr.land/)
- [Catppuccin Theme](https://catppuccin.com/)
