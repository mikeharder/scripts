#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <branch-name>" >&2
    exit 1
fi

name=$1

git worktree add --no-checkout -b "$name" "../$name"
cd "../$name"
git sparse-checkout init --cone
git sparse-checkout set .github/actions .github/shared .github/workflows eng
git checkout
