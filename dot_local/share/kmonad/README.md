# kmonad — ~/.local/share/kmonad/

Physical keyboard remapping configurations for [kmonad](https://github.com/kmonad/kmonad).

## Contents

| File | Purpose |
|------|---------|
| `alechron-at.kbd` | Linux built-in keyboard (AT / PS/2 interface) |
| `alechron-usb.kbd` | Linux external USB keyboard |

## Keyboard Layout

| Layer | Caps Lock behavior | Other |
|-------|-------------------|-------|
| base | Esc on tap, Ctrl on hold; Esc ⟷ Caps swapped | default layer |
| game | pure Esc (no tap-hold delay) | for games |
| normal | standard Caps Lock | standard keyboard |

Right Ctrl toggles layers via multi-tap: 1 tap = `rctrl`, 2 taps = switch to base, 3 taps = game, 4 taps = normal.

## Deployment

A systemd service reads configs from `/etc/kmonad/`. A symlink at `/etc/kmonad/` points to this directory so that kmonad picks up the latest config on restart.

## Conventions

- File naming: `<hostname>-<interface>.kbd`
- After editing a `.kbd` file, restart the kmonad service: `sudo systemctl restart kmonad`
- Each `.kbd` file should be self-contained — no shared includes between keyboard types
