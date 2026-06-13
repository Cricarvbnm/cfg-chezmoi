# kmonad — ~/.local/share/kmonad/

Physical keyboard remapping configurations for [kmonad](https://github.com/kmonad/kmonad).

## Contents

| File | Purpose |
|------|---------|
| `alechron-at.kbd` | AT keyboard mapping (laptop built-in keyboard) |
| `alechron-usb.kbd` | USB keyboard mapping (external keyboard on specific port) |

## Deployment

A systemd service reads configs from `/etc/kmonad/`. A symlink at `/etc/kmonad/` points to this directory so that kmonad picks up the latest config on restart.

## Conventions

- File naming: `<hostname>-<interface>.kbd`
- After editing a `.kbd` file, restart the kmonad service: `sudo systemctl restart kmonad`
- Each `.kbd` file should be self-contained — no shared includes between keyboard types
