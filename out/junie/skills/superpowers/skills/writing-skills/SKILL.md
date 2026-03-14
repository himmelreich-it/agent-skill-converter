---
name: writing-skills
description: Use when creating new skills, editing existing skills, or verifying skills work before deployment.
allowed-tools: bash, create, update_status, agent_skill_read_doc
---

# Writing Skills

**Writing skills IS Test-Driven Development (TDD) applied to process documentation.**

You write test cases (pressure scenarios with personas), watch them fail (baseline behavior), write the skill (documentation), watch tests pass (personas comply), and refactor (close loopholes).

**Core principle:** If you didn't watch an agent/persona fail without the skill, you don't know if the skill teaches the right thing.

## TDD Mapping for Skills

| TDD Concept | Skill Creation |
|-------------|----------------|
| **Test case** | Pressure scenario with persona |
| **Production code** | Skill document (SKILL.md) |
| **Test fails (RED)** | Persona violates rule without skill |
| **Test passes (GREEN)** | Persona complies with skill present |
| **Refactor** | Close loopholes while maintaining compliance |

## The Process

### 1. RED Phase: Baseline Testing
Run a test scenario WITHOUT the skill. You MUST see what a persona naturally does before writing the skill.
- **Create pressure scenarios**: Combine time pressure, authority, and consequences.
- **Run without skill**: Give the persona a realistic task with these pressures.
- **Document rationalizations**: Note the exact excuses used to skip the rule.

### 2. GREEN Phase: Write Minimal Skill
Write a `SKILL.md` that addresses the specific failures you observed.
- **Keep it focused**: Only address the observed rationalizations.
- **YAML Frontmatter**: Include `name` and `description` (Max 1024 chars total).
- **Triggers**: Use "Use when..." in the description.

### 3. VERIFY GREEN: Pressure Testing
Run the same scenarios WITH the skill.
- The persona should now comply with the rule despite the pressure.
- If it still fails, the skill is unclear or incomplete. Revise and re-test.

### 4. REFACTOR: Plug Loopholes
If the persona finds a new way to rationalize away the rule, update the skill to counter it.

## Skill Structure (SKILL.md)
- **YAML Frontmatter**: `name` and `description`.
- **Overview**: What the skill is for.
- **The Process/Rule**: Clear, actionable steps.
- **Red Flags/Rationalizations**: List common excuses and their reality.
- **Key Patterns**: Examples of correct vs. incorrect application.

## Integration
- **Testing Skills**: Use the `testing-skills` persona by loading `agents/testing-skills/SKILL.md` via `agent_skill_read_doc` for systematic verification.
- **TDD Skill**: Apply the same Red-Green-Refactor mindset.
