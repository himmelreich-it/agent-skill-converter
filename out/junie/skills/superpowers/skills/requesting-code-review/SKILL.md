---
name: requesting-code-review
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements.
allowed-tools: bash, update_status, agent_skill_read_doc
---

# Requesting Code Review

Adopt the `code-reviewer` persona to catch issues before they compound. The reviewer persona gets precisely crafted context for evaluation—never your full session history. This keeps the review focused on the work product.

**Core principle:** Review early, review often.

## When to Request Review

**Mandatory:**
- After each task in subagent-driven development.
- After completing a major feature.
- Before merging into the main branch.

## How to Request

1. **Get git context**: Identify the range of changes (e.g., base SHA and current SHA).
2. **Adopt the `code-reviewer` persona**: Load the `agents/code-reviewer/SKILL.md` skill via `agent_skill_read_doc`.
3. **Provide review context**: 
   - What was implemented.
   - The requirements/plan.
   - The diff or files to review.
4. **Act on feedback**:
   - Fix **Critical** issues immediately.
   - Fix **Important** issues before proceeding.
   - Note **Minor** issues for later.
   - Push back if you believe the reviewer is technically wrong (with reasoning).

## Integration with Workflows

- **Subagent-Driven Development**: Review after EACH task.
- **Executing Plans**: Review after each batch of tasks (e.g., 3 tasks).
- **Ad-Hoc Development**: Review before final merge.

## Red Flags
- Skipping review because "it's simple".
- Ignoring Critical issues.
- Proceeding with unfixed Important issues.
- Arguing without technical proof.
