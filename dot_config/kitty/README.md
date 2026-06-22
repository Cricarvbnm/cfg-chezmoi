# Kitty — ~/.config/kitty/

Kitty terminal emulator configuration. All settings use kitty defaults except for the color theme.

## Contents

| File | Purpose |
|------|---------|
| `kitty.conf` | Main config: includes the theme file; all other settings are commented out (kitty defaults) |
| `current-theme.conf` | [Catppuccin Macchiato](https://github.com/catppuccin/kitty) color scheme, managed by the kitty [themes kitten](https://sw.kovidgoyal.net/kitty/kittens/themes/) |

## How It Works

```
kitty.conf  ──include──▶  current-theme.conf
(empty/minimal)           (Catppuccin Macchiato colors)
```

- `kitty.conf` contains only the `include current-theme.conf` directive plus commented-out defaults for reference
- `current-theme.conf` is generated/updated by `kitty +kitten themes` and contains all color definitions (foreground, background, 16 ANSI colors, cursor, borders, tab bar)

## Changing the Theme

```bash
# Use the interactive theme picker
kitty +kitten themes

# This updates current-theme.conf; then chezmoi tracks the change
chezmoi diff
chezmoi apply
```

## Conventions

- Theme file is separate from main config for clean separation: colors vs behavior
- All non-theme settings rely on kitty defaults unless explicitly uncommented
- The `# BEGIN_KITTY_THEME` / `# END_KITTY_THEME` markers in `kitty.conf` are used by the themes kitten to identify theme boundaries
