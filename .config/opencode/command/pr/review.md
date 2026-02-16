---
description: Review changes [ref]
agent: plan
model: anthropic/claude-opus-4-6
---

You are helping review a pull request. Please provide a thorough, structured review.

**PR to review:** $ARGUMENTS

**Review process:**

1. Fetch the PR details using GitHub CLI
2. Check existing review comments
3. Analyze the code changes in the diff
4. Read modified files to understand context beyond the diff
5. Identify missing changes that should have been made:
   - **Missing Logic**: Related code that should be updated but wasn't
   - **Missing Tests**: Test cases that should exist for the new functionality
6. Provide structured feedback covering:
   - **Code Quality**: Logic, readability, maintainability
   - **Security**: Potential vulnerabilities or security concerns
   - **Performance**: Efficiency and optimization opportunities
   - **Testing**: Test coverage and quality
   - **Architecture**: Design decisions and patterns
   - **Dependencies**: New dependencies and their appropriateness
   - **Completeness**: What's missing that should have been included
   - Potential bugs or edge cases

**For each area, provide:**

- ✅ What looks good
- ⚠️ Areas for improvement
- 🔴 Critical issues (if any)

**End with an overall recommendation:** APPROVE, REQUEST CHANGES, or COMMENT.

**If no PR number/URL is provided:** Find the PR for the current branch. If on main branch, list open PRs and ask which one to review.

Use these GitHub CLI commands:

- `gh pr view` - Get PR details and reviews
- `gh pr diff` - Get code changes
