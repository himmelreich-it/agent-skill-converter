# claude-to-vibe

Transform the [Claude Code feature-dev plugin](https://github.com/anthropics/claude-code/tree/main/plugins/feature-dev) into [Mistral Vibe](https://mistral.ai/products/vibe) Skills and Agents.

## What this does

The Claude Code `feature-dev` plugin provides a guided 7-phase feature development workflow using three specialized subagents (code-explorer, code-architect, code-reviewer). This project converts that plugin into the equivalent Mistral Vibe format:

- **Claude Code commands** (`.md` with table frontmatter) → **Vibe Skills** (`SKILL.md` with YAML frontmatter)
- **Claude Code agents** (`.md` in `agents/`) → **Vibe Agents** (`.toml` in `agents/`) + **Vibe subagents**

## Source: feature-dev plugin structure

```
claude/plugins/feature-dev/
├── .claude-plugin/plugin.json       # Plugin manifest
├── commands/feature-dev.md          # 7-phase orchestration command
└── agents/
    ├── code-explorer.md             # Codebase analysis (sonnet)
    ├── code-architect.md            # Architecture design (sonnet)
    └── code-reviewer.md             # Code review with confidence scoring (sonnet)
```

## Target: Vibe skill + agent structure

```
~/.vibe/skills/feature-dev/
├── SKILL.md                         # Main skill (slash command /feature-dev)
├── references/
│   └── workflow.md                  # Detailed phase instructions
└── scripts/                         # Any helper scripts

~/.vibe/agents/
├── code-explorer.toml               # Read-only subagent
├── code-architect.toml              # Read-only subagent
└── code-reviewer.toml               # Read-only subagent
```

## Key mapping decisions

| Claude Code concept | Vibe equivalent |
|---|---|
| `plugin.json` manifest | `SKILL.md` YAML frontmatter |
| Command `.md` (table frontmatter) | `SKILL.md` (YAML frontmatter, `user-invocable: true`) |
| Agent `.md` files | `.toml` agent configs + system prompt `.md` files |
| `tools:` CSV in agent frontmatter | `enabled_tools` list in `.toml` |
| `model: sonnet` | `active_model = "devstral-2"` |
| Agent `color:` field | No direct equivalent |
| `$ARGUMENTS` in commands | Vibe slash command arguments |
| `TodoWrite` tool | `todo` tool |
| Parallel agent launches via `Task` | `task` tool with `agent` parameter |
