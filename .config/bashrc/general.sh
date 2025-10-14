# bashrc configurations for small, miscellaneous definitions and calls

mkcd() {
    mkdir -p -- "${1}"
    cd -P -- "${1}"
}

export PLAYDATE_SDK_PATH=/home/clintc/external/PlaydateSDK-2.7.5
export PATH=$PATH:${HOME}/bin:${HOME}/.local/bin/

