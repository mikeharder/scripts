#!/bin/bash

# List all repositories for the authenticated user and check if Actions are enabled
gh repo list --json name,owner --limit 1000 | jq -c '.[]' | while read repo; do
    owner=$(echo "$repo" | jq -r '.owner.login')
    name=$(echo "$repo" | jq -r '.name')
    actions_enabled=$(gh api -H "Accept: application/vnd.github+json" "/repos/$owner/$name/actions/permissions" | jq -r '.enabled')

    if [ "$actions_enabled" == "true" ]; then
        echo "$owner/$name: Actions are enabled"
    else
        echo "$owner/$name: Actions are disabled"
    fi
done
