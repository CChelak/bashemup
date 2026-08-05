#!/usr/bin/env bash
# Install the baseline tools this setup expects.
#
# Usage:
#   ./install-deps.sh            # install everything
#   ./install-deps.sh --dry-run  # just show what would be installed

set -euo pipefail

# Packages to install, by apt name. Add new tools here.
APT_PACKAGES=(
  clangd  # C/C++ language server
  curl    # also how vim-plug and lazy.nvim get fetched
  fd-find # fd, used by LazyVim's file pickers
  gcc     # nvim-treesitter compiles parsers with a C compiler
  git     # vim-plug and lazy.nvim clone over git
  lazygit # git TUI (not in apt before Ubuntu 25.04 / Debian 13)
  npm
  python3
  python3-pip # pip
  ripgrep     # rg, used by LazyVim's grep pickers
  sqlite3
  unzip # some LazyVim LSP/tool downloads arrive zipped
  vim
)

# Suffix a package with ":classic" if its snap requires classic confinement
# (check with `snap info <pkg>` — classic snaps show "classic" next to the version).
SNAP_PACKAGES=(
  nvim:classic
  tree
  zig:classic
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
      $SUDO env DEBIAN_FRONTEND=noninteractive apt-get install -y "${available[@]}"
    fi
  fi

  if [[ ${#missing[@]} -gt 0 ]]; then
    echo
    echo "!!! not available in apt on this release: ${missing[*]}"
  fi
}

install_snap() {
  echo "==> snap detected"

  if [[ $DRY_RUN -eq 0 ]]; then
    $SUDO snap refresh
  fi

  # Split the list into what this release actually carries and what it doesn't,
  # so one missing package doesn't abort the whole install. Classic-confinement
  # snaps are tracked separately since they need their own `snap install` call.
  local available=() available_classic=() missing=() entry pkg
  for entry in "${SNAP_PACKAGES[@]}"; do
    pkg="${entry%%:*}"
    if snap info "$pkg" >/dev/null 2>&1; then
      if [[ "$entry" == *:classic ]]; then
        available_classic+=("$pkg")
      else
        available+=("$pkg")
      fi
    else
      missing+=("$pkg")
    fi
  done

  if [[ ${#available[@]} -gt 0 ]]; then
    echo "==> installing: ${available[*]}"
    if [[ $DRY_RUN -eq 0 ]]; then
      $SUDO snap install "${available[@]}"
    fi
  fi

  if [[ ${#available_classic[@]} -gt 0 ]]; then
    echo "==> installing (classic): ${available_classic[*]}"
    if [[ $DRY_RUN -eq 0 ]]; then
      $SUDO snap install --classic "${available_classic[@]}"
    fi
  fi

  if [[ ${#missing[@]} -gt 0 ]]; then
    echo
    echo "!!! not available in snap on this release: ${missing[*]}"
  fi
}

main() {
  local pkg_mgr_found=false
  if command -v apt-get >/dev/null 2>&1; then
    install_apt
    pkg_mgr_found=true
  fi

  if command -v snap >/dev/null 2>&1; then
    install_snap
    pkg_mgr_found=true
  fi

  if [[ "$pkg_mgr_found" != true ]]; then
    echo "No supported package manager found (only apt is handled so far)." >&2
    echo "Detected: $(. /etc/os-release 2>/dev/null && echo "${PRETTY_NAME:-unknown}")" >&2
    exit 1
  fi

  echo
  echo "==> done"
}

main "$@"
