# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Initialization and customization happens in .config/bashrc
CONFIGS=$HOME/.config
source $CONFIGS/bashrc/init.sh

FILES_STR=$(find $CONFIGS/bashrc -name '*.sh' -not -name 'init.sh')
FILES=($(echo $FILES_STR | tr '\n' ' '))

for FILE in "${FILES[@]}"; do
    source $FILE
done

unset FILES_STR FILES CONFIGS

