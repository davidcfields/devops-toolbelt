# Resume Point — devops-toolbelt

## Mission
Build a portable, public DevOps toolbelt repo (bash + Go) with reusable scripts and blueprints for devcontainers and self-hosted apps.

## Current status
- Repo created at ~/Dev/devops-toolbelt
- Directory structure in place (scripts/, lib/, docs/, out/)
- tmux clipboard fixed on macOS (pbcopy integration)

## Last completed step
Confirmed repo structure with `tree -a -L 3`.

## Next step
1) Finish repo docs (README + conventions)
2) Add Script #1: scripts/host/audit.sh
3) Run audit and save output to out/
4) Commit and publish to GitHub

## Notes / gotchas
- Keep macOS default zsh; enforce bash in devcontainers/Linux
- Balance skillset: bash for quick wins, Go for portable CLIs
- Avoid committing any secrets (kubeconfig, .env, keys)
