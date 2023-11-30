#!/bin/bash
set -e

if [ $# -ne 1 ]; then
    echo 'One argument expected'
    exit 1
fi

if ! git rev-parse --verify --quiet $1 >> /dev/null; then
    echo "$1 isn't git object"
    exit 1
fi

if git merge-base --is-ancestor HEAD $1; then
    git merge --ff-only $1
    exit 0
fi

if git merge-base --is-ancestor $1 HEAD; then
    if ! (git branch | grep -w $1 >> /dev/null); then
        echo "$1 isn't a branch"
        exit 1
    fi
    git branch -f $1 HEAD
    git checkout $1
    exit 0
fi

echo "Neither HEAD is ancestor of $1 nor $1 is ancestor of HEAD"
exit 1
