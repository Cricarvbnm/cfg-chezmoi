# dot_agents — ~/.agents/

AI agent skills and plugins, providing specialized workflows for coding, documentation, and system tasks.

## Organization

### antigravity-awesome-skills (External)

Base skill collection from [GitHub: sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills). Managed as an `archive` external in `.chezmoiexternal.toml`.

### exact_skills/

Per-skill symlinks that selectively enable individual skills. Each symlink in this directory points to one skill definition in the external collection. Naming convention: `exact_<skill-name>` or `symlink_<skill-name>`.

The `symlink_all-skills` file is a single pointer symlink to `antigravity-awesome-skills/skills`, enabling everything at once.

Currently enabled skills include:
- Language/framework: Python, Django, FastAPI, Go, Bash
- Development: testing, debugging, linting, commit, TDD
- Documentation: readme, docx, pptx, xlsx, PDF
- Workflow: git workflows, changelog, kaizen, brainstorming

### Understand-Anything (External)

Plugin from [GitHub: Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) for codebase understanding and knowledge graph generation. Managed as an `archive` external.

Contains a `run_once_pnpm_sync.sh` script that chezmoi executes on first apply to install pnpm dependencies.

## Conventions

- Symlinks are the standard way to enable/disable skills
- External archives are refreshed weekly (168h) via `.chezmoiexternal.toml`
- New skills can be added by creating new symlinks in `exact_skills/`
