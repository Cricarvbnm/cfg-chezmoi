---
name: chezmoi-templates
description: Reference for chezmoi's Go text/template system. Use when the user asks about template syntax, needs to conditionally configure a file based on machine data, or wants to understand how .tmpl files, template data, functions, and .chezmoiignore interact.
---

# chezmoi-templates

Reference skill covering chezmoi's template system. This skill explains the mechanism — it does not prescribe specific usage. Template design decisions belong to the user.

## How Templates Work

chezmoi uses **Go text/template + sprig** as its templating engine. When a file triggers templating, chezmoi renders it before writing to the target. The rendered output is what ends up on the target machine — the template source stays in the source tree.

A file is treated as a template if:
- Its name ends with `.tmpl` (the `.tmpl` suffix is stripped from the target filename), **or**
- It lives in a `.chezmoitemplates/` directory

## Template File Naming

Source filenames carry attributes via prefixes/suffixes. The full chain is:

```
encrypted_ → private_ → readonly_ → empty_ → executable_ → dot_ → name → .tmpl
```

Example: `private_dot_gitconfig.tmpl` → target `~/.gitconfig`, permissions 600.

Key conventions:
- `dot_` prefix → target filename gets a leading `.` (e.g. `dot_config/` → `~/.config/`)
- `private_` prefix → 600 permissions for files, 700 for directories
- `executable_` prefix → target file gets executable bit
- `empty_` prefix → keep the file even if template renders to empty string
- `.tmpl` suffix → enable template processing (stripped from target name)
- `literal_` prefix → don't interpret the next prefix; keep it as part of the filename

Runtime switching: `chezmoi chattr +t <file>` marks as template, `-t` unmarks.

**Empty output behavior**: when a template renders to an empty string, the target file is **deleted** (unless `empty_` prefix is present). This is a common pattern for conditionally removing files on certain machines.

**Dot-files in source tree** (not `dot_` prefixed — actual `.`-prefixed names) are ignored by chezmoi by default, so they can be used as include fragments without being deployed.

## Template Syntax

Delimiters: `{{ }}` (strip whitespace with `{{- -}}`).

Standard Go template actions:
```
{{ .chezmoi.hostname }}                    — print variable
{{ if .condition }}...{{ end }}           — conditional
{{ if eq .chezmoi.os "linux" }}...{{ end }} — comparison
{{ range $item := .list }}...{{ end }}    — loop
{{ with .value }}...{{ end }}             — scoped block
{{ define "name" }}...{{ end }}           — named template
{{/* comment */}}                          — comment
```

Available boolean and comparison functions: `and`, `or`, `not`, `eq`, `ne`, `lt`, `le`, `gt`, `ge`. Note: `eq` accepts multiple args — `eq x y z` means "x equals y or x equals z".

Test templates with: `chezmoi execute-template '{{ .chezmoi.hostname }}'`

## Template Data (Variables)

### Built-in `.chezmoi.*` variables (commonly useful subset)

| Variable | Description |
|----------|-------------|
| `.chezmoi.hostname` | Short hostname (before first `.`) |
| `.chezmoi.fqdnHostname` | Full hostname |
| `.chezmoi.os` | `linux`, `darwin`, etc. |
| `.chezmoi.arch` | `amd64`, `arm64`, etc. |
| `.chezmoi.username` | Current username |
| `.chezmoi.homeDir` | Home directory path |
| `.chezmoi.sourceDir` | Source tree path (`~/.local/share/chezmoi`) |
| `.chezmoi.sourceFile` | Template's relative path in source tree |
| `.chezmoi.targetFile` | Target file's absolute path |
| `.chezmoi.osRelease` | Parsed `/etc/os-release` (Linux only) |
| `.chezmoi.kernel` | Kernel name |

See `chezmoi data` for the full set on the current machine.

### Custom data (precedence: later overrides earlier)

1. `.chezmoidata.$FORMAT` files (JSON/YAML/TOML, read alphabetically, **dicts merge, lists replace**)
2. `[data]` section in the chezmoi config file (`~/.config/chezmoi/chezmoi.toml`)

Example config:

```toml
[data]
    personal = true
    proxy = true
```

Usage in template: `{{ if .personal }}...{{ end }}`

### Configuration templates

The config file itself can be a template: `.chezmoi.$FORMAT.tmpl` in the source tree. It executes before other templates, but has restricted access: no `.chezmoidata` or `.chezmoitemplates` available.

## Template Functions

Three layers: Go builtins, sprig library (~70 functions), and chezmoi-specific functions.

### Frequently useful chezmoi functions

| Function | Purpose | Example |
|----------|---------|---------|
| `include` | Render another file from source tree | `{{ include ".common.sh" }}` |
| `includeTemplate` | Render from `.chezmoitemplates/` | `{{ includeTemplate "part.tmpl" . }}` |
| `output` | Run command, capture stdout | `{{ output "whoami" }}` |
| `joinPath` | Platform-aware path join | `{{ joinPath .chezmoi.homeDir ".ssh" }}` |
| `stat` | Check if path exists (returns nil if not) | `{{ if stat "~/.ssh/id_rsa" }}...{{ end }}` |
| `fromJson` / `fromYaml` / `fromToml` | Parse into dict | `{{ (fromJson (.data.something)).key }}` |
| `toJson` / `toYaml` / `toToml` | Serialize | `{{ .myData \| toYaml }}` |
| `replace` / `replaceAllRegex` | String substitution | `{{ "foo" \| replace "o" "a" }}` |
| `quoteList` / `shellQuote` | Shell-safe quoting | `{{ .args \| quoteList }}` |
| `glob` | Match filesystem patterns | `{{ glob "~/.config/**/*.conf" }}` |
| `lookPath` | Find executable in PATH | `{{ if lookPath "nvim" }}...{{ end }}` |
| `encrypt` / `decrypt` | Explicit encryption (age/gpg) | — |
| `abortEmpty` | Fail if value is empty | `{{ .requiredValue \| abortEmpty }}` |

Full list at: https://www.chezmoi.io/reference/templates/functions/

## Templates vs `.chezmoiignore`

Different mechanisms, complementary:

| | Template | `.chezmoiignore` |
|---|---|---|
| Scope | **Content-level**: same file, different content per machine | **File-level**: skip entire files/directories |
| Matches | Template data conditions | Target path patterns (doublestar globs) |
| Granularity | Fine (per-line, per-block) | Coarse (per-file, per-directory) |

`.chezmoiignore` is **always interpreted as a template** (whether or not it has `.tmpl` suffix). `!` prefix excludes a path from ignoring. `#` introduces a comment.

Example: `{{ if ne .chezmoi.hostname "work" }}.work-stuff{{ end }}` — skips `.work-stuff` dir on non-work machines.

## `.chezmoiexternal.toml.tmpl`

External dependency definitions are **also always interpreted as templates**. Individual entries can be wrapped in conditions. See `@chezmoi-add-external` for the workflow.

## Encryption Interaction

`encrypted_` prefix and `.tmpl` suffix work together: the file is decrypted first, then the decrypted content is rendered as a template. The attributes are orthogonal — `private_` controls permissions, `encrypted_` controls at-rest protection, `.tmpl` enables rendering.

## Common Patterns (for reference only)

These are examples of what templates enable — how to use them is the user's decision:

1. **Hostname-conditional block**:
   ```
   {{ if eq .chezmoi.hostname "desktop" }}...{{ end }}
   ```

2. **Boolean data switch**:
   ```
   {{ if .personal }}personal-setting = true{{ end }}
   ```

3. **Shared template fragment in `.chezmoitemplates/`**:
   ```
   {{ template "common.tmpl" . }}
   ```

4. **Loop over list from data**:
   ```
   {{ range .packages }}{{ . }}{{ end }}
   ```

5. **Cross-platform file via `include`**: `dot_bashrc` includes platform fragments like `.bashrc_linux` (dot-prefixed files ignored by chezmoi, used only for include)

## Key Points

- `.tmpl` suffix enables templating; remove it and the file is copied literally
- Templates render in the source tree; output goes to the target tree
- Empty template output = delete the target file (unless `empty_` prefix)
- `.chezmoiignore` and `.chezmoiexternal.*` are always templates
- Custom data comes from `[data]` in chezmoi config or `.chezmoidata` files
- Test with `chezmoi execute-template`, inspect with `chezmoi data`
