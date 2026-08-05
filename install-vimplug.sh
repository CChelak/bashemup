#!/usr/bin/env bash

# vim-plug is not packaged, so fetch it straight into Vim's autoload dir. The
# vimrc skips its plugin block when this file is absent, so failing here only
# costs plugins -- it does not break Vim.
install_vim_plug() {
  local dest="${HOME}/.vim/autoload/plug.vim"

  if [[ -f "$dest" ]]; then
    echo "==> vim-plug already present ($dest)"
    return 0
  fi

  echo "==> installing vim-plug -> $dest"
  [[ $DRY_RUN -eq 1 ]] && return 0

  if ! command -v curl >/dev/null 2>&1; then
    echo "!!! curl not available, skipping vim-plug" >&2
    return 0
  fi

  # Don't let a network failure abort the whole install.
  if ! curl -fsSL --create-dirs -o "$dest" \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; then
    echo "!!! failed to download vim-plug, skipping" >&2
    rm -f "$dest"
  fi
}

install_vim_plug "$@"
