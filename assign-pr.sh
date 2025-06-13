#!/usr/bin/env bash
set -e

PR_LINK="$1"
PR_CREATOR="$2"

if [[ -z "$PR_LINK" || -z "$PR_CREATOR" ]]; then
  echo "Usage: $0 <pr_link> <pr_creator>"
  exit 1
fi

echo "Assigning pull request creator '$PR_CREATOR' to PR: $PR_LINK"

gh pr edit "$PR_LINK" --add-assignee "$PR_CREATOR"
