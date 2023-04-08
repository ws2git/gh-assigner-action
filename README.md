# Auto Assign PR Creator

Automatically assigns the pull request creator as the assignee when a new PR is opened.  
This GitHub Action is useful for teams who want to ensure PR creators are always responsible for their own pull requests unless reassigned.

---

## Features

- **Automatic Assignment**: Instantly assigns the pull request creator as the assignee.
- **Simple Integration**: One-step usage in any workflow.
- **Powered by GitHub CLI**: Uses the official [GitHub CLI](https://cli.github.com/) for secure PR management.
- **Organization-wide**: Can be used across any repository.


## Usage

### 1. **Prerequisites**

- Your workflow **must pass the pull request URL and creator login** to this action.
- This action expects the [GitHub CLI (`gh`)](https://cli.github.com/) to be available (it is pre-installed on all GitHub-hosted runners).
- The environment variable `GH_TOKEN` must be set to a valid GitHub token with `repo` and `pull_requests` write permissions (by default, `${{ github.token }}` will suffice for most repositories).


### 2. **Example Workflow Integration**

```yaml
name: Auto Assign PR Creator

on:
  pull_request:
    types: [opened]

jobs:
  auto-assign-pr-creator:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      pull-requests: write
    steps:
      - name: Auto-assign PR creator
        uses: ws2git/gh-assigner-action@v1
        env:
          GH_TOKEN: ${{ github.token }}
        with:
          pr_url: ${{ github.event.pull_request.html_url }}
          pr_creator: ${{ github.event.pull_request.user.login }}
```

---

## Inputs

| Name        | Required | Description                                  |
|-------------|----------|----------------------------------------------|
| `pr_url`    | Yes      | The URL of the pull request to assign        |
| `pr_creator`| Yes      | The GitHub username of the PR creator        |


## How It Works

Internally, this action calls a shell script that uses the [GitHub CLI](https://cli.github.com/) to edit the pull request and add the creator as an assignee.

**Script logic:**
```bash
gh pr edit "$PR_LINK" --add-assignee "$PR_CREATOR"
```

If either parameter is missing, the script exits with an error.


## Permissions

- The action requires `pull-requests: write` permission to assign users to a PR.
- By default, `${{ github.token }}` is sufficient if your repository allows actions to create and edit pull requests.
- If your organization restricts `GITHUB_TOKEN` permissions, use a Personal Access Token (PAT) as a secret:
  ```yaml
  env:
    GH_TOKEN: ${{ secrets.YOUR_PAT }}
  ```


## Support

If you find a bug or have a question, [open an issue](https://github.com/ws2git/gh-assigner-action/issues).
