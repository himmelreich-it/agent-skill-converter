---
name: using-superpowers
description: Use when starting any conversation - establishes how to find and use skills, requiring skill invocation before any response or task.
allowed-tools: agent_skill_read_doc, update_status
---

# Using Superpowers

Establish how to find and use skills. If you think there is even a 1% chance a skill might apply to what you are doing, you ABSOLUTELY MUST invoke it.

**Announce at start:** "I'm using the `using-superpowers` skill to establish my workflow."

## The Rule

**Invoke relevant or requested skills BEFORE any response or action.** Even a 1% chance a skill might apply means you should invoke the skill to check. If an invoked skill turns out to be wrong for the situation, you don't need to use it.

## Instruction Priority

Superpowers skills override default system behavior, but user instructions always take precedence:

1. **User's explicit instructions** (`CLAUDE.md`, direct requests, etc.) — highest priority.
2. **Superpowers skills** — override default system behavior where they conflict.
3. **Default system behavior** — lowest priority.

## How to Access Skills

Use the `agent_skill_read_doc` tool to load skill documentation. When you invoke a skill, follow its instructions directly.

## Skill Types

### Rigid
Follow exactly (e.g., TDD, debugging). Don't adapt away discipline.

### Flexible
Adapt principles to context (e.g., patterns).

## Red Flags
These thoughts mean STOP—you're rationalizing and should check for skills:
- "This is just a simple question."
- "I need more context first." (Skill check comes BEFORE clarifying questions).
- "Let me explore the codebase first." (Skills tell you HOW to explore).
- "I can check files quickly."
- "The skill is overkill." (Simple things become complex. Use it).

## Skill Selection order

When multiple skills could apply, use this order:
1. **Process skills first** (brainstorming, debugging) — these determine HOW to approach the task.
2. **Implementation skills second** (TDD, specific feature skills) — these guide execution.
