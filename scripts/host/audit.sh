#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# audit.sh
# Portable host audit (macOS / Linux)
# -----------------------------------------------------------------------------

JSON=false
OUT_FILE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --json) JSON=true; shift ;;
    --out)  OUT_FILE="$2"; shift 2 ;;
    -h|--help)
      sed -n '1,40p' "$0"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

timestamp="$(date '+%Y-%m-%d_%H-%M-%S')"
OUT_FILE="${OUT_FILE:-out/host-audit-${timestamp}.txt}"
mkdir -p out

hostname_cmd() { hostname 2>/dev/null || uname -n; }
shell_cmd()    { printf '%s\n' "${SHELL:-unknown}"; }
uptime_cmd()   { uptime || true; }

safe() {
  "$@" 2>/dev/null || printf 'not available\n'
}

collect() {
  printf '== %s ==\n' "$1"
  shift
  safe "$@"
  printf '\n'
}

if [[ "$JSON" == "false" ]]; then
  {
    printf 'Host Audit Report\n'
    printf 'Generated: %s\n\n' "$(date)"

    collect "Hostname" hostname_cmd
    collect "OS" uname -a
    collect "Shell" shell_cmd
    collect "User" whoami
    collect "Uptime" uptime_cmd

    collect "Git" git --version
    collect "Docker" docker --version
    collect "kubectl" kubectl version --client --short
    collect "tmux" tmux -V
    collect "Go" go version
    collect "Python" python3 --version
    collect "Node" node --version

    collect "Disk Usage" df -h
  } | tee "$OUT_FILE"

  printf 'Audit written to %s\n' "$OUT_FILE"
else
  {
    printf '{\n'
    printf '  "hostname": "%s",\n' "$(hostname_cmd)"
    printf '  "os": "%s",\n' "$(uname -s)"
    printf '  "kernel": "%s",\n' "$(uname -r)"
    printf '  "shell": "%s",\n' "${SHELL:-unknown}"
    printf '  "user": "%s",\n' "$(whoami)"
    printf '  "git": "%s",\n' "$(git --version 2>/dev/null || echo not-available)"
    printf '  "docker": "%s",\n' "$(docker --version 2>/dev/null || echo not-available)"
    if command -v kubectl >/dev/null 2>&1; then
      kubectl_ver="$(kubectl version --client 2>/dev/null | tr '\n' ' ' | sed 's/"/\\"/g')"
    else
      kubectl_ver="not-available"
    fi
    printf '  "kubectl": "%s",\n' "$kubectl_ver"
    printf '  "tmux": "%s",\n' "$(tmux -V 2>/dev/null || echo not-available)"
    printf '  "go": "%s",\n' "$(go version 2>/dev/null || echo not-available)"
    printf '  "python": "%s",\n' "$(python3 --version 2>/dev/null || echo not-available)"
    printf '  "node": "%s"\n' "$(node --version 2>/dev/null || echo not-available)"
    printf '}\n'
  } | tee "$OUT_FILE"

  printf 'Audit written to %s\n' "$OUT_FILE"
fi
