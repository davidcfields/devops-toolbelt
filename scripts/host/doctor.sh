#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# doctor.sh
#
# Purpose:
#   Diagnose why common DevOps tools are missing on the host and suggest
#   next actions. Portable across macOS and Linux.
#
# Usage:
#   ./scripts/host/doctor.sh
# -----------------------------------------------------------------------------

have() {
  command -v "$1" >/dev/null 2>&1
}

where() {
  command -v "$1" 2>/dev/null || true
}

section() {
  printf "\n== %s ==\n" "$1"
}

check_cmd() {
  local cmd="$1"
  if have "$cmd"; then
    printf "%-10s OK      %s\n" "$cmd" "$(where "$cmd")"
  else
    printf "%-10s MISSING\n" "$cmd"
  fi
}

is_macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}

section "System"
echo "Hostname: $(hostname 2>/dev/null || uname -n)"
echo "OS:       $(uname -s) $(uname -r)"
echo "Shell:    ${SHELL:-unknown}"
echo "Tmux:     $(tmux -V 2>/dev/null || echo not-available)"

section "Tools"
check_cmd git
check_cmd docker
check_cmd kubectl
check_cmd go
check_cmd python3
check_cmd node

section "Guidance"

if ! have docker; then
  echo "- docker: missing"
  if is_macos; then
    echo "  macOS: choose ONE container engine (Docker Desktop OR Rancher Desktop)."
    echo "  Ensure the app is running and provides a docker CLI."
  else
    echo "  Linux: install Docker Engine or Podman via your distro."
  fi
fi

if ! have kubectl; then
  echo "- kubectl: missing"
  echo "  Options:"
  echo "    - Keep kubectl container-only (clean host, recommended)"
  echo "    - Install on host later if needed"
fi

if ! have go; then
  echo "- go: missing"
  echo "  Options:"
  echo "    - Keep Go container-only for now"
  echo "    - Install Go on host if you want local Go development"
fi

echo
echo "Tip: Re-run ./scripts/host/audit.sh after changes to capture a new baseline."
