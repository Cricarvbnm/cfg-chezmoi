# texmf — ~/texmf/

Local TeX tree for custom LaTeX packages and styles.

## Contents

| Path | Purpose |
|------|---------|
| `tex/latex/` | Custom LaTeX `.sty` / `.cls` files |
| `run_once_texhash.sh` | chezmoi run-once script: executes `texhash ~/texmf` on first apply |

## How It Works

- LaTeX searches `~/texmf/` automatically (it's part of the standard TDS root search path)
- After adding/removing files in `tex/latex/`, run `texhash ~/texmf` to rebuild the filename database
- The `run_once_texhash.sh` script handles this on initial chezmoi apply
- For subsequent changes, run `texhash ~/texmf` manually or re-apply chezmoi

## Conventions

- Follow TDS (TeX Directory Structure) layout: `tex/latex/<package-name>/`
- Keep package files minimal — personal helper packages, not full libraries
