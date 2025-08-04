#!/bin/bash

set -e

mkdir -p ~/.local/bin

cat <<EOF > ~/.local/bin/wofi-launcher
#!/bin/sh
export GTK_THEME=Adwaita-dark
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export GDK_BACKEND=wayland,x11

wofi --show drun

EOF

chmod +x ~/.local/bin/wofi-launcher