# Copilot Instructions for mikeharder/scripts

## Repository Overview

This repository contains a collection of utility scripts for various development and system administration tasks. The scripts are primarily focused on GitHub Actions management, repository synchronization, and TypeSpec package version checking.

## Tech Stack

- **Shell Scripts**: Bash (primary scripting language)
- **Python**: Python 3 for async operations
- **JavaScript**: Node.js for npm-related utilities
- **Tools**: GitHub CLI (`gh`), git, npm

## Repository Structure

```
scripts/
├── .github/               # GitHub configuration and workflows
├── .vscode/               # VS Code configuration
├── old/                   # Archived/legacy scripts
├── disable-actions.sh     # Disable GitHub Actions in a repository
├── disable-all-workflows.sh # Disable all active workflows in a repository
├── list-actions.sh        # List GitHub Actions
├── sync-forks.sh          # Sync forked repositories
├── tsp-packages.js        # Check TypeSpec package versions (Node.js)
├── tsp-packages.py        # Check TypeSpec package versions (Python)
├── upgrade.sh             # System upgrade script
└── README.md              # Repository documentation
```

## Coding Standards

### Shell Scripts

- Use `#!/usr/bin/env bash` shebang
- Enable strict mode: `set -euo pipefail`
- Use meaningful variable names in UPPERCASE for global variables
- Include usage instructions in comments at the top
- Validate input arguments and provide clear error messages
- Use GitHub CLI (`gh`) for GitHub API interactions
- Always check authentication before making API calls
- Disable pagers for non-interactive output (e.g., `git --no-pager`)

### Python Scripts

- Use `#!/usr/bin/env python3` shebang
- Use async/await for concurrent operations
- Follow PEP 8 style guidelines
- Use meaningful function and variable names in snake_case

### JavaScript/Node.js Scripts

- Use `#!/usr/bin/env node` shebang
- Use async/await for asynchronous operations
- Use const/let, never var
- Use Promises for concurrent operations

## Common Commands

### Running Scripts

All executable scripts can be run directly:
```bash
./disable-all-workflows.sh <owner> <repo>
./tsp-packages.py
./tsp-packages.js
```

### Testing Scripts

Currently, there is no automated test suite. Manual testing is performed by:
1. Running scripts with valid inputs
2. Verifying expected output
3. Checking for proper error handling with invalid inputs

## Project Guidelines

### When Making Changes

1. **Minimal Changes**: Make surgical, focused changes to address specific issues
2. **Preserve Existing Behavior**: Don't modify working code unless necessary
3. **Error Handling**: Ensure proper input validation and error messages
4. **Documentation**: Update README.md if adding new scripts or changing usage
5. **Executable Permissions**: Ensure scripts have executable permissions (`chmod +x`)

### Git Workflow

- Work on feature branches
- Commit messages should be clear and concise
- Test scripts manually before committing

### Security Considerations

- Never commit secrets or credentials
- Use environment variables or GitHub CLI authentication for API access
- Validate all user inputs to prevent command injection
- Be cautious with shell command interpolation

### Scripts Conventions

- Scripts should be idempotent where possible
- Provide clear usage instructions and examples
- Exit with appropriate status codes (0 for success, non-zero for errors)
- Use descriptive echo messages with emojis for user feedback (✅ ❌ ⚠️)

### GitHub Actions Workflows

- Set permissions at the workflow level as the default
- Only override permissions at the job level when specific jobs need different access
- Use latest versions of actions (e.g., `actions/checkout@v6`)
- Use `ubuntu-slim` runner for lightweight, fast-running tasks (linting, formatting, etc.)
- Use `ubuntu-latest` for resource-intensive or long-running tasks
- Always set explicit permissions following the principle of least privilege
- Use custom code over third-party actions when simple and maintainable

## Known Limitations

- No automated testing infrastructure
- Scripts are designed for Unix-like environments (Linux, macOS)
- Windows compatibility is limited (some .cmd and .ps1 scripts available)

## Dependencies

- **Bash**: Version 4.0 or higher
- **GitHub CLI**: `gh` must be installed and authenticated
- **Python**: Python 3.6 or higher
- **Node.js**: Node.js 12 or higher
- **Git**: Git 2.0 or higher

## Best Practices

1. Always test scripts in a safe environment before using in production
2. Keep scripts simple and focused on a single task
3. Use `gh` CLI for GitHub API interactions instead of raw curl
4. Include help/usage messages for all scripts
5. Handle edge cases and provide informative error messages
