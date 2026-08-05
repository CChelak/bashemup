#!/usr/bin/env bash
# Install the baseline tools this setup expects.
#
# Usage:
#   ./install-deps.sh            # install everything
#   ./install-deps.sh --dry-run  # just show what would be installed

set -euo pipefail

# Packages to install, by apt name. Add new tools here.
APT_PACKAGES=(
  clangd       # C/C++ language server
  lazygit      # git TUI (not in apt before Ubuntu 25.04 / Debian 13)
  ripgrep      # rg
  python3
  python3-pip  # pip
  sqlite3
  npm
)

DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

# Use sudo only when we aren't already root.
SUDO=""
if [[ $EUID -ne 0 ]]; then
  SUDO="sudo"
fi

install_apt() {
  echo "==> apt detected"

  if [[ $DRY_RUN -eq 0 ]]; then
    $SUDO apt-get update
  fi

  # Split the list into what this release actually carries and what it doesn't,
  # so one missing package doesn't abort the whole install.
  local available=() missing=() pkg
  for pkg in "${APT_PACKAGES[@]}"; do
    if apt-cache show "$pkg" >/dev/null 2>&1; then
      available+=("$pkg")
    else
      missing+=("$pkg")
    fi
  done

  if [[ ${#available[@]} -gt 0 ]]; then
    echo "==> installing: ${available[*]}"
    if [[ $DRY_RUN -eq 0 ]]; then
      $SUDO DEBIAN_FRONTEND=noninteractive apt-get install -y "${available[@]}"
    fi
  fi

  if [[ ${#missing[@]} -gt 0 ]]; then
    echo
    echo "!!! not available in apt on this release: ${missing[*]}"
    echo "!!! install these another way (see README)"
  fi
}

main() {
  if command -v apt-get >/dev/null 2>&1; then
    install_apt
  else
    echo "No supported package manager found (only apt is handled so far)." >&2
    echo "Detected: $(. /etc/os-release 2>/dev/null && echo "${PRETTY_NAME:-unknown}")" >&2
    exit 1
  fi

  echo
  echo "==> done"
}

main "$@"
