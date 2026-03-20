#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "Usage: $0 [-n] <repo> <author> <title-string> [<title-string>...]"
  echo "  -n            Dry run — list matching PRs without approving"
  echo "  Example: $0 owner/repo user 'hello world'"
  echo "  Example: $0 -n owner/repo user 'hello' 'world'"
  exit 1
}

# --- Dry run flag ---
DRY_RUN=false
if [[ "${1:-}" == "-n" ]]; then
  DRY_RUN=true
  shift
fi

if [[ $# -lt 3 ]]; then
  usage
fi

REPO="$1"
AUTHOR="$2"
shift 2  # Remove repo and author from arguments

# Escape a title string for safe use in a GitHub search phrase.
# - Escapes backslashes and double quotes, so the result can be wrapped in "
escape_github_search_phrase() {
  local s=$1
  s=${s//\\/\\\\}
  s=${s//\"/\\\"}
  printf '%s' "$s"
}

# Build search query for multiple title strings (OR logic)
SEARCH_QUERY=""
TITLE_COUNT=$#
for TITLE_STRING in "$@"; do
  ESCAPED_TITLE=$(escape_github_search_phrase "$TITLE_STRING")
  if [[ -z "$SEARCH_QUERY" ]]; then
    SEARCH_QUERY="\"$ESCAPED_TITLE\" in:title"
  else
    SEARCH_QUERY="$SEARCH_QUERY OR \"$ESCAPED_TITLE\" in:title"
  fi
done

# Parenthesize combined OR clauses for clarity when multiple titles are used
if [[ "$TITLE_COUNT" -gt 1 ]]; then
  SEARCH_QUERY="($SEARCH_QUERY)"
fi
# --- Preflight checks ---
if ! command -v gh &>/dev/null; then
  echo "Error: gh CLI is not installed. See https://cli.github.com"
  exit 1
fi

if ! gh auth status &>/dev/null; then
  echo "Error: gh is not authenticated. Run 'gh auth login' first."
  exit 1
fi

# --- Fetch matching PRs ---
echo "Search query: $SEARCH_QUERY"
echo "Fetching PRs..."
PR_LIST=$(gh pr list \
  --repo "$REPO" \
  --state open \
  --author "$AUTHOR" \
  --search "$SEARCH_QUERY" \
  --limit 200 \
  --json number,title,reviews \
  --jq '.[] | "\(.number) \(if (.reviews | map(select(.state == "APPROVED")) | length > 0) then "APPROVED" else "PENDING" end) \(.title)"') || {
    echo "Error: Failed to fetch PRs. Check that '$REPO' exists and you have access."
    exit 1
  }

if [[ -z "$PR_LIST" ]]; then
  echo "No matching PRs found."
  exit 0
fi

# --- Summary ---
echo ""
echo "Matched PRs:"
while IFS= read -r LINE; do
  PR_NUMBER=$(echo "$LINE" | awk '{print $1}')
  PR_STATUS=$(echo "$LINE" | awk '{print $2}')
  PR_TITLE=$(echo "$LINE" | cut -d' ' -f3-)
  echo "  #$PR_NUMBER [$PR_STATUS]: $PR_TITLE"
done <<< "$PR_LIST"
echo ""

if [[ "$DRY_RUN" == true ]]; then
  echo "Dry run complete. No PRs were approved."
  exit 0
fi

# --- Confirm and approve ---
while IFS= read -r LINE; do
  PR_NUMBER=$(echo "$LINE" | awk '{print $1}')
  PR_STATUS=$(echo "$LINE" | awk '{print $2}')
  PR_TITLE=$(echo "$LINE" | cut -d' ' -f3-)

  if [[ "$PR_STATUS" == "APPROVED" ]]; then
    echo "Already approved — PR #$PR_NUMBER: $PR_TITLE"
  else
    echo "PR #$PR_NUMBER: $PR_TITLE"
    read -rn 1 -p "Approve this PR? (y/N): " CONFIRM </dev/tty
    echo

    if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
      if gh pr review "$PR_NUMBER" --repo "$REPO" --approve; then
        echo "Approved PR #$PR_NUMBER"
      else
        echo "Warning: Failed to approve PR #$PR_NUMBER (you may be the author, or lack permission)"
      fi
    else
      echo "Skipped PR #$PR_NUMBER"
    fi
  fi

  echo ""
done <<< "$PR_LIST"

echo "Done."
