#!/usr/bin/env bash

# Usage: ./disable-all-workflows.sh <owner> <repo>
# Written by AI

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <owner> <repo>"
  exit 1
fi

OWNER=$1
REPO=$2

# ensure GH CLI is logged in
if ! gh auth status > /dev/null 2>&1; then
  echo "❌ GitHub CLI not authenticated. Run 'gh auth login' first."
  exit 1
fi

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
  echo -n "Disabling workflow ID $id… "
  gh api \
    --method PUT \
    /repos/"$OWNER"/"$REPO"/actions/workflows/"$id"/disable \
    && echo "OK" \
    || echo "FAILED"
done

echo "✅ Done—disabled all active workflows in $OWNER/$REPO."
