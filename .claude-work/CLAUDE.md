# CLAUDE.md

## Editing Rules

This codebase uses TABS for Go files and spaces for TypeScript files. When using the Edit tool, always match the exact indentation characters (tabs vs spaces) from the original file. Read the file first and inspect whitespace before editing.

## PR Descriptions

When asked to write/update a PR description

1. Read the PR template
2. Read recent merged PRs for style
3. Generate and push the description directly using `gh pr edit`. Do NOT enter plan mode for this task.

## Refactoring Tasks

When asked to replace/rename across multiple files: immediately start making changes file by file. Do not create a plan document. If there are more than 10 files, work through them in batches of 5, running the build after each batch.
