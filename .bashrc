# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/clintc/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/clintc/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/clintc/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/clintc/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Initialization and customization happens in .config/bashrc
CONFIGS=$HOME/.config
source $CONFIGS/bashrc/init.sh

FILES_STR=$(find $CONFIGS/bashrc -name '*.sh' -not -name 'init.sh')
FILES=($(echo $FILES_STR | tr '\n' ' '))

for FILE in "${FILES[@]}"; do
    source $FILE
done

unset FILES_STR FILES CONFIGS


