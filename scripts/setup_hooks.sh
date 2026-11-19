#!/usr/bin/env bash
# Run once after cloning: turns on the pre-commit data check for this clone.
set -e
git config core.hooksPath .githooks
echo "Pre-commit data check enabled (core.hooksPath=.githooks)."
