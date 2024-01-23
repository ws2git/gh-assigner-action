#!/usr/bin/env bash
#
# assign-pr.sh
#
# DESCRIPTION:
# This script is designed to assign the creator of a Pull Request (PR)
# to that same PR using the GitHub CLI tool ('gh').
# It requires two positional arguments: the link to the PR and the username
# of the PR creator.
#
# USAGE EXAMPLE:
# ./assign-pr-creator.sh https://github.com/OWNER/REPO/pull/123 john.doe
#
# LICENSING:
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -euo pipefail

PR_LINK="${1:?The Pull Request link is a requirement.}"
PR_CREATOR="${2:?A valid GitHub username is required.}"

echo "Assigning pull request creator '$PR_CREATOR' to PR: $PR_LINK"

gh pr edit "$PR_LINK" --add-assignee "$PR_CREATOR"
