#!/usr/bin/env bash
set -euo pipefail

# Resolve this script's directory so it can be run from anywhere,
# e.g. `~/projects/bashemup/install.sh` while cwd is ~.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TIMESTAMP="$(date +%Y%m%d%H%M%S)"

# Copies src to dest, backing up any existing dest first as dest.bak.<timestamp>.
# Works for both files and directories.
backup_and_copy() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        cp -a "$dest" "${dest}.bak.${TIMESTAMP}"
        echo "Backed up $dest -> ${dest}.bak.${TIMESTAMP}"
    fi

    cp -r "$src" "$dest"
    echo "Installed $dest"
}

backup_and_copy "$SCRIPT_DIR/bashrc" ~/.bashrc
backup_and_copy "$SCRIPT_DIR/vimrc" ~/.vimrc
backup_and_copy "$SCRIPT_DIR/inputrc" ~/.inputrc
backup_and_copy "$SCRIPT_DIR/gitconfig" ~/.gitconfig

mkdir -p ~/.config
backup_and_copy "$SCRIPT_DIR/config/bashrc" ~/.config/bashrc
backup_and_copy "$SCRIPT_DIR/config/nvim" ~/.config/nvim

"$SCRIPT_DIR/install-deps.sh"
