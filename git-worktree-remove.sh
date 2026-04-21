#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <branch-name>" >&2
    exit 1
fi

name=$1

git worktree remove "../$name"
git branch -D "$name"
