#/bin/bash

set -e

# adjust bash terminal colors
NEW_PS1="\[\e]0;\${debian_chroot:+(\$debian_chroot)}\u@\h: \w\a\]\[\033[38;2;30;129;176m\]\u@\h\[\033[0m\]:>"
sed -i "/^case \"\\\$TERM\" in/,/^esac/ s|^\(\s*\)PS1=.*$|\1PS1='$NEW_PS1'|" ~/.bashrc