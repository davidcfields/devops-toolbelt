# Conventions

## Philosophy
- Host stays minimal. Heavy tooling lives in dev containers.
- Scripts are products: versioned, documented, safe defaults.
- Prefer portability across macOS + Linux + Windows (via WSL).

## When to use Bash vs Go vs Python
### Use Bash for
- Simple glue tasks
- One-liners promoted into scripts
- Host audits / environment checks
- Wrappers around existing CLIs (docker/kubectl/git)

### Use Go for
- Tools that need to run everywhere reliably (single binary)
- Anything reused frequently or shared with others
- Structured output (JSON), parsing, validations
- Kubernetes tooling and automation helpers

### Use Python for
- Python is used for logic-heavy automation and services, primarily inside dev containers.
- for APIs and complex automation
- the task is logic-heavy
- structured data processing is needed
- speed of development matters more than binary portability
- Python handles applications and higher-level automation

Rule of thumb:
> Start in Bash. If it becomes important/reused or needs structure → rewrite as Go CLI.

## Script standards (Bash)
- Shebang: `#!/usr/bin/env bash`
- `set -euo pipefail`
- Functions and clear logging
- `--help` supported
- `--dry-run` for destructive operations
- Exit codes: 0 success, non-zero failure

## Output standards
- Human-readable by default
- Optional `--json` for machine-readable output
- Write report files to `out/` (ignored by git)

## Security
Never commit:
- kubeconfigs, cloud creds, SSH keys
- `.env` files with secrets
- certificates or private keys
