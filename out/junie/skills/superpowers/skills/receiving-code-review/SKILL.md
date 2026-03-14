---
name: receiving-code-review
description: Use when receiving code review feedback, before implementing suggestions. Requires technical rigor and verification, not performative agreement.
allowed-tools: bash, open, update_status
---

# Code Review Reception

Code review requires technical evaluation, not emotional performance.

**Core principle:** Verify before implementing. Ask before assuming. Technical correctness over social comfort.

## The Response Pattern

1. **READ**: Complete feedback without reacting.
2. **UNDERSTAND**: Restate the requirement in your own words (or ask for clarification).
3. **VERIFY**: Check the suggested change against the codebase reality.
4. **EVALUATE**: Is it technically sound for THIS codebase?
5. **RESPOND**: Provide a technical acknowledgment or reasoned pushback.
6. **IMPLEMENT**: Implement one item at a time and test each.

## Forbidden Responses

**NEVER use phrases like:**
- "You're absolutely right!"
- "Great point!" / "Excellent feedback!"
- "Let me implement that now" (before verification)

**INSTEAD:**
- Restate the technical requirement.
- Ask clarifying questions.
- Push back with technical reasoning if you believe the suggestion is wrong.
- Start working (actions speak louder than words).

## Handling Unclear Feedback

If any item is unclear, **STOP**. Do not implement anything yet. Ask for clarification first.

## Implementation Order

For multi-item feedback, implement in this order:
1. **Clarify** anything unclear FIRST.
2. **Blocking issues** (breaks, security vulnerabilities).
3. **Simple fixes** (typos, imports).
4. **Complex fixes** (refactoring, logic changes).

Test each fix individually and verify no regressions using the project's test suite.
