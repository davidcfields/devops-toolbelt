# devops-toolbelt

A portable, public DevOps toolbelt: reusable scripts and small CLIs for host audits, devcontainer scaffolding, and Kubernetes workflows.

## Goals
- Keep laptops/desktops/macbooks clean by running project tooling inside **Dev Containers**
- Standardize repeatable automation (scripts are version-controlled and documented)
- Build a portfolio of real-world DevOps automation (Bash + Go + Python)

## Repo structure
- `scripts/` — user-facing commands (Bash)
- `lib/` — shared helpers for scripts (logging, OS detection, requirements)
- `docs/` — conventions, runbooks, and resume points
- `out/` — generated reports (not committed)

## Quick start
```bash
git clone git@github.com:davidcfields/devops-toolbelt.git ~/Dev/devops-toolbelt
cd ~/Dev/devops-toolbelt
