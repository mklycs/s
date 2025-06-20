#/bin/bash

set -e

mkdir ~/.config/kitty
touch ~/.config/kitty/kitty.conf
cat <<EOF > ~/.config/kitty/kitty.conf
background_opacity 0.5
dynamic_background_opacity yes

EOF