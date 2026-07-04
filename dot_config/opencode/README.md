# OpenCode — ~/.config/opencode/

Configuration for the [OpenCode](https://opencode.ai/) AI coding agent.

## Contents

| File | Purpose |
|------|---------|
| `opencode.json` | Core agent configuration |
| `oh-my-opencode-slim.json` | Plugin configuration |
| `tui.json` | Terminal UI preferences |
| `AGENTS.md` | Agent instructions (explicitly included via `.chezmoiignore`) |
| `package.json` / `package-lock.json` | Agent plugin dependencies |

> **关于 `AGENTS.md`**：它是被部署到 `~/.config/opencode/` 的 AI agent 行为守则（由 `.chezmoiignore` 显式 include），**不是**本仓库的目录说明文档。修改它等于改 agent 行为，而非改仓库文档。
