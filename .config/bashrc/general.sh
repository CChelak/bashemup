# bashrc configurations for small, miscellaneous definitions and calls

mkcd() {
    mkdir -p -- "${1}"
    cd -P -- "${1}"
}

export PLAYDATE_SDK_PATH=/usr/lib/PlaydateSDK-1.12.3
export PATH=$PATH:${HOME}/bin:${HOME}/.local/bin/


