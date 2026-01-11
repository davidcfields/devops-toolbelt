# Base Dev Container Blueprint

A minimal, language-agnostic devcontainer foundation:
- Debian slim base
- bash as the default shell
- common utilities: curl, git, ssh client, procps, less
- non-root `vscode` user

## Use this when
You want a clean starting point and will layer language/tooling on top (Python, Go, Node, etc.).

## Notes
This blueprint is intentionally minimal to keep build times fast and reduce attack surface.
