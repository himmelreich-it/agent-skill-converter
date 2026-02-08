# Agent Skill Converter

Convert AI coding assistant plugins between different platforms to prevent vendor lock-in and promote ecosystem interoperability.

## Why this exists

[Claude Code](https://github.com/anthropics/claude-code) has excellent plugins, but we don't want any single platform to become a monopoly. This tool ensures that great agent workflows can work across multiple AI coding assistants—**Mistral Vibe**, **GitHub Copilot**, and others.

## What this does

Convert skills (slash commands) and agents (subagents) between platforms:

- **From Claude Code** → Mistral Vibe, GitHub Copilot
- **From Mistral Vibe** → GitHub Copilot, Claude Code  
- **From GitHub Copilot** → Mistral Vibe, Claude Code

### Supported conversions

| Component | Claude Code | Mistral Vibe | GitHub Copilot |
|-----------|-------------|--------------|----------------|
| **Skills** | `.md` (table frontmatter) | `SKILL.md` (YAML frontmatter) | `SKILL.md` (YAML frontmatter) |
| **Agents** | `.md` in `agents/` | `.toml` config files | `.md` in `.github/agents/` |
| **Tool names** | `Bash`, `Read`, `Write`, `Grep`, `Glob` | Same | `execute`, `read`, `edit`, `search` |
| **Model field** | `model: sonnet` | `active_model = "devstral-2"` | Omitted (auto-selected) |

## Example: Converting feature-dev plugin

### Source (Claude Code)
```
claude/plugins/feature-dev/
├── .claude-plugin/plugin.json       # Plugin manifest
├── commands/feature-dev.md          # 7-phase orchestration command
└── agents/
    ├── code-explorer.md             # Codebase analysis subagent
    ├── code-architect.md            # Architecture design subagent
    └── code-reviewer.md             # Code review subagent
```

### Target: Mistral Vibe
```
out/vibe/
├── skills/feature-dev/
│   ├── SKILL.md                     # Converted skill with YAML frontmatter
│   └── references/workflow.md       # Supporting documentation
└── agents/
    ├── code-explorer.toml           # Converted agent config
    ├── code-architect.toml
    └── code-reviewer.toml
```

### Target: GitHub Copilot
```
out/copilot/
├── skills/feature-dev/
│   ├── SKILL.md                     # Converted skill (Agent Skills spec)
│   └── references/README.md         # Supporting documentation
└── agents/
    ├── code-explorer.md             # Converted agent with YAML frontmatter
    ├── code-architect.md
    └── code-reviewer.md
```

## Usage

### Validate converted skills

```bash
# Works with both Vibe and Copilot formats
uv run skills-ref validate ./out/copilot/skills/feature-dev
uv run skills-ref validate ./out/vibe/skills/feature-dev
```

### Install to platform

```bash
# Install Vibe skills and agents
./install-skills.sh

# Copilot skills are automatically discovered in workspace
# (no installation needed if in .github/ or copilot-skills.json)
```

## Project structure

- `claude/plugins/` - Source plugins from Claude Code
- `out/vibe/` - Converted Mistral Vibe format
- `out/copilot/` - Converted GitHub Copilot format
- `src/skills_ref/` - Python library for parsing and validating Agent Skills
- `docs/` - Platform-specific documentation

## Development

```bash
# Run tests
uv run pytest

# Lint code
uv run ruff check .

# Format code
uv run ruff format .
```

## Key conversion mappings

See [`CLAUDE.md`](CLAUDE.md) for complete conversion reference tables and platform-specific notes.

| Concept | Claude Code | Vibe | Copilot |
|---------|-------------|------|---------|
| Frontmatter | Table syntax | YAML | YAML |
| Subagent tool | `Task` | `task` with `agent` | `agent` alias |
| File operations | `Read`, `Write` | Same | `read`, `edit` |
| Shell execution | `Bash` | `bash` | `execute` |
| Code search | `Grep`, `Glob` | Same | `search` |

## References

- [Agent Skills Specification](https://agentskills.io/specification) - Open standard used by Vibe and Copilot
- [Claude Code plugins](https://github.com/anthropics/claude-code/tree/main/plugins) - Original plugin source
- [Mistral Vibe](https://mistral.ai/products/vibe) - Mistral's coding assistant
- [GitHub Copilot Custom Agents](https://docs.github.com/en/copilot/customizing-copilot/creating-custom-agents) - Copilot agent documentation
