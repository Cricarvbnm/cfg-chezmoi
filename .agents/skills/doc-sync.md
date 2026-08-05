---
name: doc-sync
description: Synchronize repository documentation with actual filesystem data. Data is the source of truth — documentation describes what exists, not what should exist. Use when asked to sync docs, check documentation consistency, or after significant config changes.
---

# doc-sync

Maintain consistency between this repository's documentation and its actual filesystem state.

## Principle

**Data is the source of truth.** Documentation describes what exists — it does not prescribe what should exist. If a documented file is missing, fix the documentation. If an undocumented file exists, the documentation is incomplete.

## Workflow

### 1. Explore Source Tree

List the files and directories in the source tree (the repo itself). Compare against what the documentation claims:
- Root `README.md` — human overview of the repository
- `AGENTS.md` — agent conventions and constraints

### 2. Cross-Reference

Check each claim in documentation:
- Does every documented file/directory actually exist in the source tree?
- Does every documented path match the actual filename?
- Are documented external dependencies present in `.chezmoiexternal.toml.tmpl`?

Check the filesystem against documentation:
- Are there directories or files that exist but aren't documented?
- Are there README files in simple directories that shouldn't have them?

### 3. Check Target Tree Divergence

Both `chezmoi status` and `chezmoi diff` read the target tree, which may contain GPG-encrypted files — either command can trigger a password prompt. Mitigate by passing explicit target paths to limit scope:

```bash
chezmoi status ~/.config ~/.local ~/.ssh ~/.agents ~/texmf
```

This restricts the scan to known managed areas. For finer control, list specific sub-paths to avoid encrypted areas entirely.

Prefer `chezmoi status` over `chezmoi diff` — status only checks existence/metadata, while diff reads content (more likely to hit encrypted files).

Report any divergence to the user — it may indicate:
- Source tree was edited but `chezmoi apply` hasn't been run
- Target tree was edited directly and needs to be copied back to source

Doc-sync does NOT resolve these — it only reports them. The user decides what to do.

### 4. Fix Documentation to Match Data

When documentation is wrong and data is correct:
- Update documentation to reflect reality

When a README exists for a simple directory that doesn't need one:
- Delete the README (simple configs are self-documenting)

When documentation references deleted items:
- Remove stale references

### 5. Report

Summarize all discrepancies found, fixes applied, and any unresolved target-tree divergence.

## Rules

- **Never create files to match documentation** — fix the documentation instead
- **Don't add READMEs to simple directories** — only complex dirs warrant READMEs
- **Source tree only** — don't confuse chezmoi source paths with target paths
- **Ask before deleting anything** the user might want to keep
- **`.chezmoiexternal.toml.tmpl` is authoritative** — not AGENTS.md or README for external dependency listings
- **Report target divergence, don't resolve it** — `chezmoi status` shows issues, user decides
