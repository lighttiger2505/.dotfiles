https://loops.elorm.xyz/loops/coverage-until-threshold

Start the "Coverage Until Threshold" loop.

Goal: coverage meets the target threshold (default 80%) with all tests passing
Max iterations: 12
Between iterations run: npm test -- --coverage
Exit when: coverage threshold is met and tests exit 0

Step 1: Run coverage. Add focused tests for the biggest uncovered gaps, then repeat.

Self-pace this loop. After each iteration, run the check command, read the output, and only continue if the exit condition is not met. Stop when the exit condition passes or max iterations is reached. Give a short status update each pass.

Guardrails (do not skip):
- Do not modify the check command or exit criteria to force success
- Do not skip, disable, or bypass checks to pass the exit condition
- If stuck after several iterations, stop and report blockers instead of gaming metrics
- Do not weaken, delete, or skip tests to make the suite pass
- Do not replace real assertions with trivial always-pass tests
- Prefer fixing production code over patching tests to go green
