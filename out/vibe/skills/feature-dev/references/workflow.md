# Feature Development Workflow - Detailed Phases

This document provides **comprehensive instructions and examples** for phases 1, 2, 4, 5, 6, and 7.

**⚠️ NOTE: Phase 3 (Clarifying Questions) is fully implemented in [../SKILL.md](../SKILL.md) with detailed inline instructions. This is the critical phase where the AI must pause and ask the user for answers before proceeding.**

See the main SKILL.md for the executable workflow. This document provides additional context, examples, and guidance.

---

## Phase 1: Discovery - Additional Context

The main SKILL.md implements Phase 1. Here's additional guidance:

**Goal**: Understand what needs to be built

### Extended Guidance

1. **Understanding feature scope**:
   - Is this a new feature, enhancement to existing feature, or replacement?
   - What problem does it solve?
   - Who are the users of this feature?
   - What are the boundaries (what's in scope, what's out)?

2. **Initial clarification questions** (if needed):
   - "When you say [feature], do you mean...?"
   - "Should this affect existing functionality, or be completely separate?"
   - "What's the primary use case?"

3. **Getting agreement**:
   - Confirm understanding before moving to Phase 2
   - Get thumbs-up on scope boundaries
   - Note any assumptions

### Example Dialogue
```
User: /feature-dev Add API rate limiting

You:
- Create todo list for all 7 phases
- "I understand you want to implement API rate limiting.
  Before I explore the codebase, let me confirm scope:
  - Should this be per-user, per-IP, or per-endpoint?
  - Should it be global or configurable per endpoint?
  - Any specific limit numbers in mind?"
- Wait for answers (or proceed if user says "just explore")
- Summarize: "Great. I understand you want X with these boundaries..."
- "Phase 1 complete. Moving to Phase 2: Codebase Exploration."
```

---

## Phase 2: Codebase Exploration - Additional Context

**Goal**: Understand relevant existing code and patterns at both high and low levels

**Prerequisite**: Phase 1 complete, scope understood

### Actions

1. **Launch 2-3 code-explorer subagents in parallel**

   Each agent should:
   - Trace through the code comprehensively
   - Focus on understanding abstractions, architecture, and flow of control
   - Target different aspects of the codebase
   - Return a list of 5-10 key files to read

   **Example agent prompts**:
   ```
   Agent 1:
   "Find features similar to [feature] and trace through their implementation comprehensively.
   Map how [related feature] is implemented from entry points through data storage.
   Document the execution flow, key files, architectural patterns, and integration points.
   Return a list of the 5-10 most important files to understand this area."

   Agent 2:
   "Map the architecture and abstractions for [feature area], tracing through the code
   comprehensively. Identify the module boundaries, data flow patterns, and design decisions.
   How do components interact? What are the key abstractions and layers?
   Return the 5-10 key files needed to understand this architecture."

   Agent 3:
   "Identify UI patterns, testing approaches, error handling, and extension points relevant
   to [feature]. What conventions does this codebase follow?
   Return the 5-10 key files that exemplify these patterns."
   ```

2. **Read all files identified by agents**

   - Agents will return lists of 5-10 key files each
   - Collect all unique files mentioned
   - Read through them to build deep understanding
   - Take notes on patterns, conventions, architecture

3. **Present comprehensive summary of findings**

   Provide:
   - **Architecture overview**: Layers, components, data flow
   - **Similar features**: How related functionality is implemented
   - **Key patterns**: Design patterns, conventions, abstractions used
   - **Technology stack**: Languages, frameworks, libraries used in this area
   - **Integration points**: Where new feature will connect
   - **Potential challenges**: Technical debt, complexity, dependencies

---

## Phase 3: Clarifying Questions - IMPLEMENTED IN MAIN SKILL

**⚠️ IMPORTANT**: Phase 3 is **fully implemented in SKILL.md** with detailed inline instructions.

This is the **CRITICAL PHASE** where the AI must pause and ask the user for answers before proceeding to architecture design.

### Phase 3 in SKILL.md

The main SKILL.md contains complete Phase 3 implementation with:
- Explicit identification of underspecified areas
- **`ask_user_question` tool invocation** to wait for user answers
- Prohibition on answering questions for the user
- Requirements to continue asking until all ambiguities are resolved

### Why Phase 3 is in the Main Skill

Phase 3 is the **gating mechanism** that forces the AI to pause. Putting it inline in SKILL.md ensures:
1. The AI explicitly asks questions (not just mentions that it should)
2. The AI waits for user responses before proceeding
3. The AI doesn't skip this critical phase
4. The workflow doesn't prematurely jump to implementation

### Underspecified Areas to Explore

When asking clarifying questions, cover:

- **Scope & Behavior**: What exactly should the feature do? Edge cases? Constraints?
- **Integration Points**: How does this connect to existing systems? Dependencies?
- **Error Handling**: How should failures be handled? Logging? Recovery?
- **Performance**: Targets? Constraints? Scalability needs?
- **Backward Compatibility**: Preserve existing code/APIs? Deprecation periods?
- **User Experience**: Any UX considerations? Accessibility?
- **Testing**: What testing approach? Coverage expectations?
- **Security**: Any security implications? Authentication? Authorization?
- **Documentation**: What needs to be documented?
- **Design Preferences**: Any architectural preferences or constraints?

### Example Question Set

```
Based on codebase exploration, I need to clarify:

**Scope & Behavior** (2-3 questions):
1. Should rate limiting be per-user, per-IP, or per-endpoint?
2. What time window (second/minute/hour)?
3. Should it be enforced globally or per-endpoint?

**Integration** (2-3 questions):
4. Where should rate limit events be logged?
5. Should certain users/endpoints have bypass capability?

**Error Handling** (1-2 questions):
6. Return 429 status, or custom error response?
7. Include retry-after headers?

**Backward Compatibility** (1-2 questions):
8. Must this work with existing API clients?
9. Any deprecation period needed for API changes?

Please answer these before I proceed to architecture design.
```

### Critical Behaviors in Phase 3

✅ DO:
- Ask specific, concrete questions
- Wait for user to answer using `ask_user_question`
- Continue asking until ambiguities are resolved
- Follow up on vague answers

❌ DON'T:
- Answer your own questions
- Guess or assume answers
- Proceed without user responses
- Skip questions or rush through this phase

---

## Phase 4: Architecture Design - Additional Context

**Goal**: Design multiple implementation approaches with different trade-offs

See main SKILL.md for Phase 4 orchestration. This section provides extended examples and guidance.

### Agent Prompt Examples

When launching code-architect agents, use focused prompts like:

**Agent 1 - Minimal Changes Approach**:
```
Design the implementation for [FEATURE] focusing on minimal changes and maximum
reuse of existing patterns. Use existing abstractions, libraries, and architectural
approaches already in the codebase. What existing components can be extended?
Prioritize fitting into the current architecture seamlessly.
Include specific files to create/modify and integration points.
```

**Agent 2 - Clean Architecture Approach**:
```
Design a clean, maintainable architecture for [FEATURE]. Prioritize elegant abstractions,
clear separation of concerns, and long-term maintainability. What new components should
be created? How should they be organized? Design for extensibility and testing.
Specify module boundaries, interfaces, and data flow.
```

**Agent 3 - Pragmatic Balance Approach**:
```
Design a pragmatic implementation of [FEATURE] balancing implementation speed with
code quality. Consider time constraints, team expertise, and project stage.
Make decisive choices that get the feature done well without over-engineering.
Include specific files and phased implementation approach.
```

### Evaluating Approaches

Consider these factors when choosing an approach:
- **Codebase fit**: How well does it align with existing patterns?
- **Maintenance**: How easy will it be to maintain and extend?
- **Time to implement**: How long will it take?
- **Team expertise**: Does the team have skills for this approach?
- **Project stage**: Early-stage MVP vs mature product?
- **Flexibility**: How easy is it to change later?

### Presenting to User

Structure your recommendation:
```
**Approach 1: [Name]**
[2-3 sentence description]
Pros: [benefits]
Cons: [trade-offs]
Files: [specific files to create/modify]

**Approach 2: [Name]**
[2-3 sentence description]
Pros: [benefits]
Cons: [trade-offs]
Files: [specific files to create/modify]

**Approach 3: [Name]**
[2-3 sentence description]
Pros: [benefits]
Cons: [trade-offs]
Files: [specific files to create/modify]

**My recommendation: Approach X**
Reasoning: [specific reasons why this approach is best]

Which approach do you prefer?
```

### Example

```
I've analyzed the architecture with code-architect agents. Here are three approaches:

**Approach 1: Middleware Extension** (Minimal Changes)
Add rate limiting to existing middleware layer. Reuse interceptor pattern.
Pros: Quick, fits patterns, minimal code
Cons: Limited flexibility, tightly coupled

**Approach 2: Service Layer** (Clean Architecture)
Create RateLimiter service with strategy pattern and configuration system.
Pros: Flexible, testable, extensible
Cons: More code, potential over-engineering

**Approach 3: Pragmatic Hybrid** (Balanced)
Create RateLimiter class in middleware layer with service-like interface.
Pros: Balance of simplicity and flexibility
Cons: Not as extensible as full service approach

**My recommendation: Approach 3**
Your project uses pragmatic patterns. This gives you flexibility without
excessive abstraction layers. Easy to refactor to Approach 2 later if needed.

Which approach do you prefer?
```

---

## Phase 5: Implementation - Additional Context

**Goal**: Build the feature

See main SKILL.md for Phase 5 orchestration. This section provides extended guidance.

### Before You Start Coding

Ensure you have:
- ✅ All clarifying questions answered (Phase 3 complete)
- ✅ Architecture approach chosen by user (Phase 4 complete)
- ✅ All relevant code files read (from Phase 2)
- ✅ Explicit user approval to proceed
- ✅ Understanding of existing code conventions

### Implementation Strategy

1. **Create new files first**:
   - Set up file structure as specified by architecture
   - Follow existing directory patterns
   - Use consistent naming conventions

2. **Modify existing files second**:
   - Integration points with existing code
   - Update dependencies and imports
   - Register new components

3. **Testing as you go**:
   - Test each component as you build
   - Ensure integration points work
   - Catch issues early

4. **Follow conventions strictly**:
   - Naming (camelCase, snake_case, PascalCase)
   - Code style and formatting
   - Error handling patterns
   - Logging approaches
   - Comment style

### Phased Implementation Example

For complex features, break into phases:
```
Phase 5A: Create core service/component
Phase 5B: Integrate with existing system
Phase 5C: Add configuration and customization
Phase 5D: Add tests and documentation
```

---

## Phase 6: Quality Review - Additional Context

**Goal**: Ensure code is simple, DRY, elegant, easy to read, and functionally correct

See main SKILL.md for Phase 6 orchestration. This section provides extended examples.

### Code Reviewer Agent Prompts

**Agent 1 - Code Quality**:
```
Review the new code for:
- Code duplication (DRY principle violations)
- Naming clarity and readability
- Overly complex vs elegant implementations
- Unnecessary abstraction or over-engineering
Focus on actual quality issues that impact maintainability.
Use high confidence threshold - only report issues you're very confident about.
```

**Agent 2 - Correctness & Bugs**:
```
Review for bugs and functional correctness:
- Logic errors and edge case handling
- Null/undefined/error condition handling
- Race conditions or concurrency issues
- Security vulnerabilities (injection, XSS, etc.)
- Performance problems
Be specific about exact scenarios where bugs would occur.
Only report issues with high confidence.
```

**Agent 3 - Project Conventions**:
```
Review for adherence to project conventions and guidelines:
- Naming conventions (variables, functions, classes)
- Code style and formatting consistency
- Architecture pattern consistency
- Project guideline violations (from CLAUDE.md if exists)
- Integration with existing abstractions and patterns
Focus on project-specific standards, not generic style opinions.
Only report issues explicitly called out in project guidelines.
```

### Consolidating Review Findings

Prioritize by:
- **Critical**: Bugs that will cause failures
- **High**: Serious quality issues affecting maintainability
- **Medium**: Nice-to-have improvements
- **Low**: Style or preference issues

### Review Consolidation Example

```
Critical Issues (fix before proceeding):
1. Memory leak in connection pooling (line 45)
2. Missing null check on user object (line 78)

Important Issues (fix now or document):
1. Duplicate validation logic (lines 23 and 67)
2. Inconsistent error handling patterns

Minor Issues (can fix later):
1. Variable naming could be clearer
2. Comment documentation could be expanded

Recommendation: Fix critical issues now, fix important issues if quick,
document minor issues for follow-up.
```

---

## Phase 7: Summary - Additional Context

**Goal**: Document what was accomplished

See main SKILL.md for Phase 7 orchestration. This section provides extended guidance.

### Summary Document Structure

```
## [Feature] Implementation Complete

**Overview**:
[1-2 sentence summary of what was built]

**Architecture**:
[Approach chosen and rationale]
[Key design decisions]

**Files Modified**:
- Created: [list files]
- Modified: [list files]

**Implementation Details**:
[Brief description of how it works]
[Key components and their responsibilities]

**How to Test**:
[Step-by-step testing instructions]
[Expected outcomes]

**Known Issues or Limitations**:
[Any issues or trade-offs]
[Future improvements]

**Next Steps**:
[Recommended follow-up work]
[Areas for enhancement]

**Notes**:
[Any special considerations for maintenance]
[Performance or scalability notes]
```

### Example Summary

```
## Rate Limiting Implementation Complete

**Overview**:
Implemented API rate limiting middleware supporting per-user and per-IP
rate limiting with configurable time windows and strategies.

**Architecture**:
Took the Pragmatic Hybrid approach - created RateLimiter class in middleware
layer with service-like interface. Uses Redis for distributed state.

**Key Decisions**:
- Token bucket algorithm for fairness and burst handling
- Redis for distributed rate limit state across instances
- Pluggable strategy pattern for different algorithms
- Configuration-driven limits per endpoint

**Files Created**:
- src/middleware/RateLimiter.ts - Main implementation
- src/config/rateLimits.ts - Configuration
- src/tests/RateLimiter.test.ts - Unit tests

**Files Modified**:
- src/middleware/index.ts - Register rate limiter
- src/types/index.ts - Add rate limit types

**How to Test**:
1. Run: npm test -- src/tests/RateLimiter.test.ts
2. Manual: curl -H "X-User-Id: 123" http://localhost/api/data 10 times
3. Should see 429 after limit exceeded

**Known Issues**:
- Redis connection required (not cached)
- Limits reset on hourly boundary (could improve precision)

**Next Steps**:
1. Add metrics/monitoring for rate limit events
2. Create admin dashboard for limit tuning
3. Add rate limit headers to responses
4. Document rate limits in API docs
5. Performance testing under high load

**Notes**:
- Consider upgrading to token bucket v2 for better burst handling
- Monitor Redis memory usage with high concurrent users
```

---

## Key Success Factors

### Phase 1: Discovery
- Keep scope clear and bounded
- Ask for clarification if needed
- Get explicit user agreement on scope

### Phase 2: Exploration
- **Actually read the files agents return** - don't skip
- Take notes on patterns, conventions, architecture
- Build real understanding of how similar features work

### Phase 3: Clarifying Questions ⭐ CRITICAL
- **This is the gating mechanism** - don't skip or rush
- Ask specific, concrete questions about edge cases
- Use `ask_user_question` tool and WAIT for responses
- Don't answer your own questions or make assumptions
- Continue asking until all major ambiguities are resolved

### Phase 4: Architecture Design
- Evaluate trade-offs fairly
- Make a confident recommendation with clear reasoning
- Present different approaches only if genuinely different
- Get explicit user choice before proceeding

### Phase 5: Implementation
- **Get explicit user approval before starting code**
- Follow existing code conventions strictly
- Break complex features into phases
- Test and integrate as you build
- Don't skip file reading from Phase 2

### Phase 6: Quality Review
- Focus on real issues that matter (not nitpicks)
- Be specific with bug descriptions and suggestions
- Use high confidence threshold (avoid false positives)
- Prioritize severity for the user

### Phase 7: Summary
- Document architectural decisions
- Flag any technical debt or concerns
- Provide concrete next steps
- Be specific about what was built and why

---

## Critical Principles

✅ **ALWAYS DO**:
- Complete each phase fully before moving to next
- Ask clarifying questions and WAIT for answers
- Read files identified by agents
- Get user approval before major decisions
- Follow codebase conventions
- Document decisions and rationale

❌ **NEVER DO**:
- Skip Phase 3 (Clarifying Questions)
- Answer your own questions in Phase 3
- Start coding before Phase 4 architecture is approved
- Assume requirements - ask instead
- Proceed without reading key files
- Rush through phases

---

## Related Resources

- Main Skill: [../SKILL.md](../SKILL.md) - Executable workflow instructions
- Agent Configs: `~/.vibe/agents/code-*.toml` - Subagent specifications
- Original Plugin: `/home/oskar/code/claude-to-vibe/claude/plugins/feature-dev/` - Claude Code version

