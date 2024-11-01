#!/bin/bash

# List all repositories for the authenticated user
gh repo list --json name,owner --limit 1000 | jq -c '.[]' | while read repo; do
    owner=$(echo "$repo" | jq -r '.owner.login')
    name=$(echo "$repo" | jq -r '.name')

    # Disable actions for the repository
    gh api -X PUT -H "Accept: application/vnd.github+json" "/repos/$owner/$name/actions/permissions" -F enabled=false

    echo "Actions disabled for $owner/$name"
done
