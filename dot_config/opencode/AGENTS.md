# AGENTS.md

<!--
  注意：本文件是部署到 ~/.config/opencode/ 的 AI agent 行为守则，
  不是 dotfiles 仓库的目录说明文档。仓库维护信息见 ~/.local/share/chezmoi/AGENTS.md。
-->

## 知识库

共享 Obsidian vault 位于 `~/knowledge/`，是跨 session 的持久记忆。

### 优先级：先查知识库，再写代码

在探索代码或编写实现之前，先检索 `~/knowledge/` 中是否已有相关知识。

### 目录约定

| 目录 | 用途 |
|------|------|
| `0-Inbox/` | 待整理的草稿和灵感 |
| `raw/` | 待 agent 消化的原始材料（文章、转写） |
| `coding/` | 编程规范和最佳实践（按语言分二级目录） |
| `development/` | 跨语言开发实践（项目结构、提交规范） |
| `tools/` | 工具链配置和使用 |
| `systems/` | 文件组织、环境管理、工作流 |
| `life/` | 生活知识 |
| `_templates/` | 笔记模板（说明了文档结构约定） |

### 使用方式

- 按领域搜索：glob `~/knowledge/coding/python/python-*.md`
- 按关键词搜索：grep `~/knowledge` 中的 `tags:` 或自由文本
- 每条笔记的 YAML frontmatter 包含 `tags`、`status`、`source`、`applicability`、`expiry`
- 笔记之间使用 `[[wikilink]]` 交叉引用
- 发现 0-Inbox 或 raw 中有内容时，使用 `knowledge-ingest` 技能主动整理
- 对话中发现值得保留的知识时，使用 `knowledge-capture` 技能提取并写入
- 定期使用 `knowledge-maintain` 技能审计知识库健康状态（链接、孤立笔记、过期规则等）

### 边界

- **Always**：写代码前先搜索知识库；发现新知识时主动记录到 0-Inbox
- **Ask first**：修改 `~/knowledge/` 中已存在的笔记
- **Never**：提交 secret 到知识库

---

## 语言与格式

- 语言默认使用简体中文，日期用 ISO 8601 格式（`YYYY-MM-DD`）
- 正文偏好键盘可直接键入的符号。Unicode 特殊字符（如 →、←）混在文字中会削弱自然语言的阅读感，但常规符号不足以表意时仍可使用
- 文档和代码中的注释优先使用英文，除非有另外指示

## 提交约定

- 使用技能 'commit' 或类似技能
- 只做本地提交，不执行 `git push`
- 不主动提交，除非有另外指示

## 问题记录

记录工程问题的结构：现象 -> 分析 -> 解决方案

## 文件引用

文档中的文件引用以可迁移为优先。相对路径可用，但跨多层目录导致路径过于复杂时，可用环境变量替代绝对路径中不可迁移的部分

## 图表

需要图示时，首选 Mermaid，优于 ASCII 字符画。目录结构仍可用字符画表示

## 技能

技能集中存放于 `~/.agents/skills/`，由 openCode 自动发现。此外 openCode 也会扫描项目目录下的 `.agents/skills/` 和 `.opencode/skills/`。

当前全局技能：

| 技能 | 用途 |
|------|------|
| `grill-with-docs` | 需求澄清：逐题逼问决策树，对照项目术语表和 ADR，自动更新 CONTEXT.md |
| `commit` | 提交：遵循 conventional commit 格式 |
| `lint-and-validate` | 代码校验：每次代码变更后运行 |
| `knowledge-*` | 知识库管理：提取、消化、维护 Obsidian vault |

项目级技能（如 `knowledge-curation`、`repo-maintenance`、`pandoc-yaml`）存放于各项目的 `.agents/skills/` 目录。
