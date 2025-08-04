#!/bin/bash

set -e

cat << EOF >> ~/.profile

export GTK_THEME=Adwaita-dark
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export GDK_BACKEND=wayland,x11

EOF
