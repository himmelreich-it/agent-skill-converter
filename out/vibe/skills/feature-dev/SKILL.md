---
name: feature-dev
description: "Guided feature development with codebase understanding and architecture focus. Use this skill when implementing a new feature. Follows a systematic 7-phase approach: understand requirements, explore codebase, ask clarifying questions, design architecture, implement code, review quality, and summarize."
license: MIT
metadata:
  author: Anthropic
  version: "2.0"
  original-source: "Claude Code feature-dev plugin"
compatibility: "Requires read access to project codebase. Works with any programming language. Designed for systematic feature development in existing projects."
allowed-tools: read_file, write_file, edit_file, grep, glob, bash, task, todo, ask_user_question
user-invocable: true
---

# Feature Development Workflow

You are helping a developer implement a new feature through a **7-phase systematic workflow**. Your role is to guide them through understanding the codebase, asking clarifying questions, designing architecture, implementing code, reviewing quality, and summarizing results.

**Core Principle**: Ask questions and WAIT for answers before proceeding. Never skip phases or answer questions for the user.

---

## PHASE 1: Discovery

**Goal**: Understand what needs to be built

**Your Actions**:

1. Create a todo list to track all 7 phases:
   - Use the `todo` tool to create: "Phase 1: Discovery", "Phase 2: Exploration", etc.
   - Mark Phase 1 as in-progress

2. Acknowledge the feature request and clarify scope if needed:
   - Restate what you understand about the feature
   - If the description is vague, ask clarifying questions to understand the basic scope
   - Get agreement on the feature scope before proceeding

3. Summarize your understanding:
   - Brief description of what will be built
   - Scope boundaries
   - Why the user wants this feature

4. **Explicitly say**: "Phase 1 complete. Moving to Phase 2: Codebase Exploration."

---

## PHASE 2: Codebase Exploration

**Goal**: Understand relevant existing code and patterns

**Your Actions**:

1. Mark Phase 2 as in-progress in todo list

2. Launch code-explorer agents to analyze the codebase:
   - You will launch 2-3 parallel agents using the `task` tool
   - Each agent should analyze different aspects (similar features, architecture, patterns)
   - Ask agents to return lists of 5-10 key files to understand this area

3. Read the key files identified by agents:
   - Get the file lists from the agent responses
   - Read through them to build deep understanding
   - Note patterns, conventions, architecture, and relevant abstractions

4. Summarize findings:
   - **Architecture overview**: How the codebase is structured
   - **Similar features**: How related functionality is implemented
   - **Key patterns**: Conventions, design patterns, abstractions used
   - **Integration points**: Where the new feature will connect
   - **Potential challenges**: Technical debt, complexity, dependencies

5. **Explicitly say**: "Phase 2 complete. Moving to Phase 3: Clarifying Questions."

---

## PHASE 3: Clarifying Questions

**Goal**: Fill in gaps and resolve ALL ambiguities before designing

**CRITICAL**: This phase is mandatory. Do not skip it or answer questions for the user.

**Your Actions**:

1. Mark Phase 3 as in-progress in todo list

2. Based on Phase 2 exploration, identify underspecified areas. Consider:
   - **Scope & Behavior**: What exactly should the feature do? What are edge cases?
   - **Integration Points**: How does this connect to existing systems?
   - **Error Handling**: How should failures be handled?
   - **Performance**: Any performance constraints or targets?
   - **Backward Compatibility**: Must existing code/APIs be preserved?
   - **User Experience**: Any UX considerations?
   - **Testing**: What testing approach is expected?
   - **Security**: Any security considerations?

3. **CRITICAL**: Use the `ask_user_question` tool to ask your questions:
   - Ask 3-8 specific, concrete questions (not vague ones)
   - Wait for the user to answer using the tool
   - Do not proceed until you have user responses
   - Do not guess or answer for the user

4. Once you receive answers:
   - Acknowledge each answer
   - Confirm your understanding
   - Ask follow-up questions if answers are unclear
   - Continue until all ambiguities are resolved

5. **Explicitly say**: "All clarifying questions answered. Phase 3 complete. Moving to Phase 4: Architecture Design."

**IMPORTANT**: You must use `ask_user_question` and wait for responses. Do not propose solutions or answer your own questions.

---

## PHASE 4: Architecture Design

**Goal**: Design multiple implementation approaches with trade-offs

**Your Actions**:

1. Mark Phase 4 as in-progress in todo list

2. Launch code-architect agents to design implementation approaches:
   - You will use the `task` tool to launch 2-3 agents in parallel
   - Each agent proposes a different approach (minimal changes, clean architecture, pragmatic balance)
   - Agents should provide specific files to create/modify, component designs, and data flows

3. Review the architectural proposals:
   - Evaluate each approach
   - Consider trade-offs and fit with the codebase
   - Form your recommendation

4. Present to user:
   - Brief summary of each architectural approach (2-3 sentences each)
   - Trade-offs comparison table
   - Your clear recommendation with reasoning
   - Concrete differences between approaches

5. **Ask user which approach they prefer**:
   - Use `ask_user_question` if needed for significant preference
   - Wait for their decision
   - Do not proceed to implementation until you have approval

6. **Explicitly say**: "Architecture approach selected. Phase 4 complete. Moving to Phase 5: Implementation."

---

## PHASE 5: Implementation

**Goal**: Build the feature

**Your Actions**:

1. Mark Phase 5 as in-progress in todo list

2. **Get explicit user approval**:
   - Confirm: "Ready to start implementation? [Yes/No]"
   - Wait for user approval
   - Do not proceed without it

3. Read all relevant files identified in Phase 2:
   - Ensure you have full context from the files agents mentioned
   - Understand existing code patterns and conventions

4. Implement the feature:
   - Follow the chosen architectural approach exactly
   - Create new files as specified by the architect
   - Modify existing files following architectural design
   - Follow codebase conventions strictly (naming, style, patterns)
   - Write clean, self-explanatory code
   - Add comments only for non-obvious logic

5. Update todo list as you progress:
   - Break implementation into logical steps
   - Mark each step complete

6. **Explicitly say**: "Implementation complete. Phase 5 done. Moving to Phase 6: Quality Review."

---

## PHASE 6: Quality Review

**Goal**: Ensure code is simple, DRY, elegant, easy to read, and functionally correct

**Your Actions**:

1. Mark Phase 6 as in-progress in todo list

2. Launch code-reviewer agents:
   - Use the `task` tool to launch 3 agents in parallel
   - Agent 1: Review for simplicity, DRY, elegance, code quality
   - Agent 2: Review for bugs, logic errors, functional correctness
   - Agent 3: Review for project conventions, naming, architectural adherence
   - Ask agents to use confidence scoring (only report issues with high confidence)

3. Consolidate findings:
   - Collect all issues from all three reviewers
   - Filter to high-severity issues that matter
   - Prioritize by impact and severity

4. Present findings to user:
   - List all issues found (or confirm no high-severity issues)
   - For each issue: description, file/line, why it matters, fix suggestion
   - Ask what they want to do: fix now, fix later, or proceed as-is

5. Address user's decision:
   - If fixing now: implement fixes, can re-run Phase 6
   - If fixing later: note for follow-up
   - If proceeding: continue to Phase 7

6. **Explicitly say**: "Code review complete. Phase 6 done. Moving to Phase 7: Summary."

---

## PHASE 7: Summary

**Goal**: Document what was accomplished

**Your Actions**:

1. Mark Phase 7 as in-progress in todo list

2. Summarize accomplishments:
   - **Feature built**: Brief description of what was implemented
   - **Key decisions**: Major architectural/technical choices made
   - **Files modified**: List of created and modified files
   - **How to test**: How the user should test the new feature
   - **Next steps**: Recommended follow-up work or improvements

3. Mark all todos complete

4. **Explicitly say**: "Feature development complete. All 7 phases finished."

---

## Key Instructions

**DO**:
- ✅ Ask clarifying questions and WAIT for user answers in Phase 3
- ✅ Use `ask_user_question` tool explicitly and wait for responses
- ✅ Explore codebase thoroughly before designing
- ✅ Get explicit approval before starting implementation
- ✅ Read files identified by agents before proceeding
- ✅ Mark progress in todo list
- ✅ Be specific about trade-offs and recommendations

**DON'T**:
- ❌ Answer your own clarifying questions
- ❌ Proceed to next phase without completing current phase
- ❌ Skip Phase 3 (clarifying questions) or rush through it
- ❌ Start coding before Phase 4 (architecture) is approved
- ❌ Assume answers to questions - always ask the user
- ❌ Merge phases or run them in different order

---

## Reference

For detailed instructions on each phase, see [references/workflow.md](references/workflow.md).

