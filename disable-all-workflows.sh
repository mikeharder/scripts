#!/usr/bin/env bash

# Usage: ./disable-all-workflows.sh <repo>
# Disables all active workflows in a repo owned by the current gh CLI user.
# Written by AI

set -euo pipefail

# Disable pager for gh CLI to prevent interactive prompts
export GH_PAGER=""

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <repo>"
  exit 1
fi

# ensure GH CLI is logged in
if ! gh auth status > /dev/null 2>&1; then
  echo "❌ GitHub CLI not authenticated. Run 'gh auth login' first."
  exit 1
fi

OWNER=$(gh api /user --jq '.login')
REPO=$1

# get IDs of only active workflows
active_ids=$(gh api \
  --method GET \
  /repos/"$OWNER"/"$REPO"/actions/workflows \
  --paginate \
  --jq '.workflows[] | select(.state=="active") | .id')

if [[ -z "$active_ids" ]]; then
  echo "No active workflows to disable in $OWNER/$REPO."
  exit 0
fi

for id in $active_ids; do
  echo -n "Disabling workflow ID ${id}… "
  gh api \
    --method PUT \
    /repos/"$OWNER"/"$REPO"/actions/workflows/"$id"/disable \
    && echo "OK" \
    || echo "FAILED"
done

echo "✅ Done—disabled all active workflows in $OWNER/$REPO."
