#/bin/bash

set -e

mkdir ~/.config/kitty
cat << EOF > ~/.config/kitty/kitty.conf
#background_opacity 0.5
#dynamic_background_opacity yes
enable_audio_bell no
EOF

# adjust bash terminal colors
echo "PS1='\[\e[34m\]\u@\h\[\e[0m\]:\w\$ '" >> ~/.bashrc
