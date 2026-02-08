# Copilot Instructions for agent-skill-converter

## Project Purpose

This project converts Claude Code plugins (from [anthropics/claude-code](https://github.com/anthropics/claude-code/tree/main/plugins)) into two target formats:

- **Mistral Vibe**: Skills (`SKILL.md`) and agent configs (`.toml`)
- **GitHub Copilot**: Skills (`SKILL.md`) and agent profiles (`.md`)

**Important**: Always ask the user which output format they want (**vibe** or **copilot**) before starting any conversion—never assume.

## Commands

### Testing
```bash
# Run all tests
uv run pytest

# Run a single test file
uv run pytest tests/test_validator.py

# Run a specific test
uv run pytest tests/test_validator.py::test_validate_basic_skill
```

### Linting & Formatting
```bash
# Run Ruff linter
uv run ruff check .

# Auto-fix issues
uv run ruff check --fix .

# Format code
uv run ruff format .
```

### Validation
```bash
# Validate a skill directory (works with either target format)
uv run skills-ref validate ./out/copilot/skills/feature-dev
uv run skills-ref validate ./out/vibe/skills/feature-dev

# Parse skill properties to JSON
uv run skills-ref properties ./out/copilot/skills/feature-dev

# Extract full prompt (frontmatter + body)
uv run skills-ref prompt ./out/copilot/skills/feature-dev
```

### Installation (for testing)
```bash
# Install Vibe skills/agents to ~/.vibe/
./install-skills.sh
```

## Architecture

### Core Components

1. **Source**: `./claude/plugins/**` - Original Claude Code plugin files
   - Commands: `.md` files with table-format frontmatter
   - Agents: `.md` files in `agents/` subdirectories

2. **Conversion logic**: `src/skills_ref/` - Python library for parsing and validating Agent Skills
   - `parser.py` - Parses YAML frontmatter from `SKILL.md` files
   - `validator.py` - Validates skills against the [Agent Skills specification](https://agentskills.io/specification)
   - `models.py` - Dataclasses for skill properties
   - `prompt.py` - Extracts full skill prompt (frontmatter + body)
   - `cli.py` - CLI commands (`validate`, `properties`, `prompt`)

3. **Output**: `./out/`
   - `out/vibe/skills/{skillname}/SKILL.md` - Vibe skills
   - `out/vibe/agents/{agent}.toml` - Vibe agent configs
   - `out/copilot/skills/{skill-name}/SKILL.md` - Copilot skills
   - `out/copilot/agents/{agent}.md` - Copilot agent profiles

### Conversion Flow

```
Claude Code Plugin (./claude/plugins/feature-dev/)
├── commands/feature-dev.md              ──→  SKILL.md (with YAML frontmatter)
└── agents/code-explorer.md              ──→  .toml (Vibe) OR .md (Copilot)
```

**Frontmatter transformation**:
- Claude Code uses table syntax: `| field | value |`
- Both target formats use YAML with `---` delimiters

**Tool name mapping** (see `CLAUDE.md` for full reference):
- Claude Code → Vibe: mostly 1:1 (`Bash`, `Read`, `Write`, `Grep`, `Glob`)
- Claude Code → Copilot: tool aliases (`execute`, `read`, `edit`, `search`)

### Skills vs Agents

**Skills** (slash commands):
- User-invocable commands (e.g., `/feature-dev`, `/create-plan`)
- Defined in `SKILL.md` with YAML frontmatter
- Follow the [Agent Skills specification](https://agentskills.io/specification)
- Same format for both Vibe and Copilot

**Agents** (subagents):
- Specialized assistants invoked by skills (e.g., `code-explorer`, `code-reviewer`)
- Vibe: `.toml` config files with `display_name`, `enabled_tools`, `active_model`
- Copilot: `.md` files in `.github/agents/` with YAML frontmatter (`name`, `description`, `tools`)

## Conventions

### File Organization
- Skills get their own directory: `{skill-name}/SKILL.md`
- Optional subdirectories: `references/` (docs), `scripts/` (executables), `assets/` (static files)
- Agent files are flat: `agents/{name}.toml` (Vibe) or `agents/{name}.md` (Copilot)

### Naming
- Skill directory names: kebab-case (e.g., `feature-dev`, `create-plan`)
- Skill names in frontmatter: match directory name
- Agent names: kebab-case for files, human-readable in `display_name`/`name` field

### Model Mapping
- Claude Code `sonnet` → Vibe `devstral-2` (Mistral's code model)
- Claude Code `sonnet` → Copilot: omit (platform selects model automatically)

### Tool Restrictions
- Skills can limit available tools via `allowed-tools` frontmatter field
- Vibe agents use `enabled_tools` list in `.toml`
- Copilot agents use `tools` list in YAML frontmatter (`["*"]` = all, `[]` = none)

## Reference Documentation

Key files for understanding conversion details:
- `CLAUDE.md` - Complete conversion mapping tables and format-specific notes
- `docs/agent-skills-specification.md` - Agent Skills spec details
- `docs/vibe-skills-and-agents.md` - Vibe-specific configuration
- `README.md` - High-level project overview

External references:
- [Agent Skills specification](https://agentskills.io/specification) - Open standard for both formats
- [Claude Code plugins](https://github.com/anthropics/claude-code/tree/main/plugins) - Source material
