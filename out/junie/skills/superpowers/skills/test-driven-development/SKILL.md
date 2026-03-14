---
name: test-driven-development
description: Use when starting any implementation task, after writing a spec, or when fixing bugs. Requires a Red-Green-Refactor cycle.
allowed-tools: bash, create, search_replace, update_status
---

# Test-Driven Development (TDD)

TDD is about confidence and quality. By writing the test first, you define what "done" looks like before you start building.

**Core principle:** Red-Green-Refactor. If you didn't watch it fail (RED), you don't know if your code actually made it pass (GREEN).

## The TDD Cycle

### 1. RED: Write a Failing Test
Before touching production code, write a test that fails due to missing functionality or the presence of a bug.
- Define a clear, focused test case.
- Run the test suite and verify it fails (e.g., using `bash`).
- Confirm it fails with the *expected* error.

### 2. GREEN: Make it Pass
Write the minimal production code needed to satisfy the test.
- Don't worry about elegance or optimization yet.
- Focus on correctness.
- Run the test suite and verify it passes (e.g., using `bash`).

### 3. REFACTOR: Clean it Up
Now that you have a passing test, improve the code without changing its behavior.
- Remove duplication (DRY).
- Improve readability and naming.
- Ensure adherence to project conventions.
- Run the test suite again to verify no regressions (REMAIN GREEN).

## Common Pitfalls
- **Skipping RED**: Writing tests after the code is already written. You lose the definition of "done".
- **Big-bang GREEN**: Implementing too much at once. Keep it small and incremental.
- **Ignoring REFACTOR**: Leaving messy code behind because it "works".
- **Fragile Tests**: Writing tests that break on any minor change. Test behavior, not implementation details.

## Benefits
- **Clear Goals**: You know exactly what you're building.
- **Regression Safety**: You can refactor with confidence.
- **Better Architecture**: TDD naturally leads to more modular and testable code.
- **Implicit Documentation**: Tests describe how the code is intended to be used.

## Integration
- **Writing Plans**: Plan tasks around the TDD cycle (Step 1: Write test, Step 2: Run test, Step 3: Implement...).
- **Systematic Debugging**: Always start a bug fix with a regression test.
