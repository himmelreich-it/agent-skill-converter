# Vibe Instructions

This file provides guidance to Mistral Vibe when working with code in this repository.

## Project Overview

This is a conversion project: transform the Claude Code  plugins  into Mistral Vibe Skills and Agents format.

**Source**: `./claude/plugins/**`
Origin: [Claude Code feature-dev plugin](https://github.com/anthropics/claude-code/tree/main/plugins)

**Target**: Mistral Vibe Skills (`SKILL.md` in `./out/vibe/skills/{skillname}/`) and Agents (`.toml` in `./out/vibe/agents/`)

## Context7
Be proactive in using context7, this will allow you to understand better the latest documentation on the libraries, frameworks and features we need to develop.
* https://context7.com/mistralai/mistral-vibe
* https://context7.com/agentskills/agentskills
* https://context7.com/anthropics/claude-code


## Format Mapping Reference

| Claude Code | Mistral Vibe |
|---|---|
| Command `.md` (table frontmatter, `description`, `argument-hint`) | `SKILL.md` (YAML frontmatter, `name`, `description`, `user-invocable`) |
| Agent `.md` (table frontmatter, `name`, `tools:`, `model:`, `color:`) | `.toml` agent config (`display_name`, `enabled_tools`, `active_model`) + separate system prompt `.md` |
| `$ARGUMENTS` variable in command body | Vibe skill argument handling (similar mechanism) |
| `TodoWrite` tool | `todo` tool in Vibe |
| Parallel `Task` tool for agent launches | `task` tool with `agent` parameter |
| `Glob, Grep, Read, Write, Bash` | Same tools exist in Vibe (`grep`, `read_file`, `write_file`, `bash`) |

## Key Conversion Notes

1. **Frontmatter**: Claude Code uses table syntax (`| field | value |`); Vibe uses YAML with `---` delimiters
2. **Skill restrictions**: Vibe's `allowed_tools` controls what tools the skill can use; Claude Code agents use `tools:` field
3. **Model mapping**: Claude Code's `sonnet` → Vibe's `devstral-2` (Mistral's code model)
4. **Subagent delegation**: Both systems support delegating to specialized agents; Vibe uses `task` tool, Claude Code uses `Task` tool
5. **System prompts**: Claude Code agents embed system prompts directly in `.md` files; Vibe separates them into `~/.vibe/prompts/` or inline in agent configs

## Additional documentation
* How skills and agents are created and configured in Vibe: `docs/vibe-skills-and-agents.md`
* Specfications of Agent Skills for Vibe: `docs/agent-skills-specification.md`
* Generic Vibe Configuration instructions: `docs/vibe-configuration.md`


## Development Workflow

When converting components:

1. **Read the source** file from Claude Code plugin which is to be converted
2. **Extract frontmatter fields** and convert to target format
3. **Adapt the instruction body** (Markdown remains mostly the same, but adjust tool/agent references)
4. **Test the conversion** by validating YAML/TOML syntax
5. **Verify tool mappings** match available Vibe tools

## Validation

Use the [Agent Skills spec validator](https://agentskills.io/specification):
```bash
skills-ref validate ./feature-dev
```

For TOML agent configs, standard TOML validators apply.
