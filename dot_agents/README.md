# dot_agents — ~/.agents/

AI agent skills and plugins, providing specialized workflows for coding, documentation, and system tasks.

## Organization

### antigravity-awesome-skills (External)

Base skill collection from [GitHub: sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills). Managed as an `archive` external in `.chezmoiexternal.toml`.

### exact_skills/

Per-skill symlinks that selectively enable individual skills. Each symlink in this directory points to one skill definition in the external collection. Naming convention: `exact_<skill-name>` or `symlink_<skill-name>`.

The `symlink_all-skills` file is a single pointer symlink to `antigravity-awesome-skills/skills`, enabling everything at once.

### Custom Local Skills

In addition to the symlinked external skills, two locally-maintained skills live directly in `exact_skills/`:

- **exact_agent-browser/** — Browser automation CLI for AI agents (web interaction, screenshots, data extraction)
- **grill-with-docs/** — Planning review session that stress-tests plans against domain model and documentation

Currently enabled skills include:
- **Language / framework**: async-python-patterns, bash-linux, django-pro, fastapi-pro, fastapi-templates, go-concurrency-patterns, golang-pro, python-patterns, python-pro
- **Development workflow**: changelog-automation, commit, concise-planning, create-branch, git-advanced-workflows, git-pushing, kaizen, lint-and-validate, python-testing-patterns, systematic-debugging
- **Documents & presentations**: documentation-templates, docx-official, libreoffice-calc, libreoffice-impress, libreoffice-writer, pdf-official, pptx-official, python-pptx-generator, readme, xlsx-official
- **Codebase understanding**: understand, understand-chat, understand-dashboard, understand-diff, understand-domain, understand-explain, understand-knowledge, understand-onboard
- **Knowledge management**: knowledge-capture, knowledge-ingest, knowledge-maintain

### Understand-Anything (External)

Plugin from [GitHub: Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) for codebase understanding and knowledge graph generation. Managed as an `archive` external.

Contains a `run_once_pnpm_sync.sh` script that chezmoi executes on first apply to install pnpm dependencies.

## Conventions

- Symlinks are the standard way to enable/disable skills
- External archives are refreshed weekly (168h) via `.chezmoiexternal.toml`
- New skills can be added by creating new symlinks in `exact_skills/`
