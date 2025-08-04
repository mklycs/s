#/bin/bash

set -e

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/BigBlueTerminal.zip
unzip ~/.local/share/fonts/BigBlueTerminal.zip
rm BigBlueTerminal.zip
fc-cache -fv

mkdir -p ~/.config/kitty
cat << 'EOF' > ~/.config/kitty/kitty.conf
font_family      BigBlueTermPlus Nerd Font Mono
background       #111D33
foreground       #FFFFFF
cursor_color     #FFFFFF

enable_audio_bell no
window_padding_width 3

color0  #000000
color1  #FF0000
color2  #00FF00
color3  #FFFF00
color4  #5C87D6
color5  #96B2E5
color6  #00FFFF
color7  #FFFFFF
EOF

# adjust bash terminal colors
echo "PS1='\[\e[34m\]\u@\h\[\e[0m\]:\w\$ '" >> ~/.bashrc
