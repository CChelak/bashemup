#!/usr/bin/env bash

# These are options I added specifically for ASI on WSL. Many could be generalized
PATH=${PATH}:/snap/bin:/home/clintc/bin:/home/clintc/.local/bin
alias ghs_release='cmake --preset gh-arm-relase && cmake --build --preset gh-arm-release'
export CFLAGS="-std=gnu17"
alias list_tgts='cmake --build --preset linux-release --target help'
alias adt_docker="docker run -it -v "/home/clintc/projects/vcu-adt:/workspace" -w /workspace --rm ghcr.io/asirobots/build-cpp-linux-x64:1.0.4 bash"

# ── WezTerm cwd reporting (OSC 7) ──────────────────────────────────────────
# Tells WezTerm which directory this shell is in so new tabs/splits inherit it
# instead of falling back to the Windows-side /mnt/c/Users/... path.
# See ~/.wezterm-notes.md (Windows home) for the why.
__wezterm_osc7() {
  printf '\033]7;file://%s%s\033\\' "${HOSTNAME}" "${PWD}"
}
case "${PROMPT_COMMAND:-}" in
*__wezterm_osc7*) ;;
*) PROMPT_COMMAND="__wezterm_osc7${PROMPT_COMMAND:+;${PROMPT_COMMAND}}" ;;
esac
