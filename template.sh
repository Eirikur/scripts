# Bash Script Rules

## Strict Mode
- Every script: set -euo pipefail after shebang
- Use #!/usr/bin/env bash, not #!/bin/bash

## Variables
- Always double-quote variable expansions: "${var}"
- Use "${array[@]}" for array expansion
- No bare $variable outside arithmetic

## Functions
- Use local for all function variables
- snake_case function names
- Extract repeated logic into functions

## Arguments
- Validate required arguments at script top
- Show usage message on invalid args
- Assign positional params to named readonly variables

## Cleanup
- Use trap cleanup EXIT for temp files
- Use mktemp, never hardcoded /tmp paths
- Clean up resources in reverse creation order

## Code Quality
- All code must pass shellcheck
- Use [[ ]] not [ ] for tests
- Use $(cmd) not backticks
- Use printf not echo -e
- Never use eval with variable input
