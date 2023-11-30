#!/bin/bash
set -e # Exit if one of commands exit with non-zero exit code
set -u # Treat unset variables and parameters other than the special parameters ‘@’ or ‘*’ as an error

git status $@

if git rev-parse --quiet --verify CHERRY_PICK_HEAD > /dev/null; then
    echo "--- Cherry-pick HEAD:"
    git --no-pager log -1 CHERRY_PICK_HEAD
fi
