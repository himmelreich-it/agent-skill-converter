# Conversion Instructions

This file provides guidance when working with code in this repository.

## Project Overview

This is a conversion project: transform the Claude Code plugins into target formats.

**Source**: `./claude/plugins/**`
Origin: [Claude Code feature-dev plugin](https://github.com/anthropics/claude-code/tree/main/plugins)

**Target formats** (the user will specify which one to use):
- **Mistral Vibe**: Skills (`SKILL.md` in `./out/vibe/skills/{skillname}/`) and Agents (`.toml` in `./out/vibe/agents/`)
- **GitHub Copilot**: Skills (`SKILL.md` in `./out/copilot/skills/{skill-name}/`) and Agents (`.md` in `./out/copilot/agents/`)

> **Important**: Before starting any conversion, ask the user which output format they want: **vibe** or **copilot**. Do not assume one or the other.

---

## Mistral Vibe Format

### Format Mapping Reference

| Claude Code | Mistral Vibe |
|---|---|
| Command `.md` (table frontmatter, `description`, `argument-hint`) | `SKILL.md` (YAML frontmatter, `name`, `description`, `user-invocable`) |
| Agent `.md` (table frontmatter, `name`, `tools:`, `model:`, `color:`) | `.toml` agent config (`display_name`, `enabled_tools`, `active_model`) + separate system prompt `.md` |
| `$ARGUMENTS` variable in command body | Vibe skill argument handling (similar mechanism) |
| `TodoWrite` tool | `todo` tool in Vibe |
| Parallel `Task` tool for agent launches | `task` tool with `agent` parameter |
| `Glob, Grep, Read, Write, Bash` | Same tools exist in Vibe (`grep`, `read_file`, `write_file`, `bash`) |

### Key Conversion Notes (Vibe)

1. **Frontmatter**: Claude Code uses table syntax (`| field | value |`); Vibe uses YAML with `---` delimiters
2. **Skill restrictions**: Vibe's `allowed_tools` controls what tools the skill can use; Claude Code agents use `tools:` field
3. **Model mapping**: Claude Code's `sonnet` → Vibe's `devstral-2` (Mistral's code model)
4. **Subagent delegation**: Both systems support delegating to specialized agents; Vibe uses `task` tool, Claude Code uses `Task` tool
5. **System prompts**: Claude Code agents embed system prompts directly in `.md` files; Vibe separates them into `~/.vibe/prompts/` or inline in agent configs

### Additional documentation (Vibe)
* How skills and agents are created and configured in Vibe: `docs/vibe-skills-and-agents.md`
* Specfications of Agent Skills for Vibe: `docs/agent-skills-specification.md`
* Generic Vibe Configuration instructions: `docs/vibe-configuration.md`

---

## GitHub Copilot Format

### Documentation References

* [Agent Skills specification (agentskills.io)](https://agentskills.io/specification) — the open standard shared by Copilot and other tools
* [Custom agents in VS Code](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
* [Custom agents configuration reference (GitHub Docs)](https://docs.github.com/en/copilot/reference/custom-agents-configuration)
* [Agent Skills in VS Code](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
* [Creating custom agents (GitHub Docs)](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-custom-agents)

### Format Mapping Reference

| Claude Code | GitHub Copilot |
|---|---|
| Command `.md` (table frontmatter, `description`, `argument-hint`) | `SKILL.md` (YAML frontmatter: `name`, `description`, optional `allowed-tools`) |
| Agent `.md` (table frontmatter, `name`, `tools:`, `model:`, `color:`) | Agent `.md` in `.github/agents/` (YAML frontmatter: `description`, `tools`, optional `name`) |
| `$ARGUMENTS` variable in command body | Same — skill body instructions reference user input |
| `TodoWrite` tool | `todo` |
| Parallel `Task` tool for agent launches | `agent` tool alias (invoke other custom agents) |
| `Glob, Grep, Read, Write, Bash` | `search` (Grep/Glob), `read` (Read), `edit` (Edit/Write), `execute` (Bash) |

### Key Conversion Notes (Copilot)

1. **Skills use the Agent Skills open standard**: `SKILL.md` with YAML frontmatter (`name`, `description`). Same spec as Vibe — see [agentskills.io/specification](https://agentskills.io/specification)
2. **Agents are Markdown files** in `.github/agents/` with YAML frontmatter (`description`, `tools`, `name`). The filename (minus `.md`) becomes the agent identifier
3. **Tool aliases**: Copilot uses aliases — `execute` (shell/bash), `read` (file reading), `edit` (file writing), `search` (grep/glob), `agent` (invoke other agents)
4. **Tools property**: `tools: ["*"]` for all tools, `tools: []` for none, or list specific ones like `tools: ["read", "edit", "search", "execute"]`
5. **Model mapping**: Claude Code's `sonnet` → omit (Copilot selects its own model) or leave to the `active_model` if the hosting platform supports it
6. **Prompt body max**: 30,000 characters for agent prompt content
7. **Directory structure for skills**:
   ```
   out/copilot/skills/{skill-name}/
   ├── SKILL.md          # Required
   ├── scripts/           # Optional executables
   ├── references/        # Optional extra docs
   └── assets/            # Optional static resources
   ```
8. **Directory structure for agents**:
   ```
   out/copilot/agents/
   └── {agent-name}.md    # Agent profile with YAML frontmatter + prompt
   ```

### Copilot Agent Frontmatter Example

```yaml
---
name: Code Reviewer
description: Reviews code for bugs, security vulnerabilities, and adherence to project conventions.
tools:
  - read
  - search
---

You are a code reviewer. Analyze the code for...
```

### Copilot Skill Frontmatter Example

```yaml
---
name: feature-dev
description: Guided feature development with codebase understanding and architecture focus. Use when the user wants to plan and implement a new feature.
allowed-tools: Bash(git:*) Read
---

## Instructions

When the user asks you to develop a feature...
```

---

## Development Workflow

When converting components:

1. **Ask the user** which output format to target: **vibe** or **copilot**
2. **Read the source** file from Claude Code plugin which is to be converted
3. **Extract frontmatter fields** and convert to the target format
4. **Adapt the instruction body** (Markdown remains mostly the same, but adjust tool/agent references per the mapping tables above)
5. **Test the conversion** by validating YAML/TOML syntax
6. **Verify tool mappings** match available tools in the target platform

## Validation

Use the [Agent Skills spec validator](https://agentskills.io/specification) for skills in either format:
```bash
skills-ref validate ./feature-dev
```

For Vibe TOML agent configs, standard TOML validators apply.
For Copilot agent Markdown files, validate that the YAML frontmatter parses correctly.
