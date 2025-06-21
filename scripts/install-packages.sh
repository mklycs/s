#!/bin/bash

set -e

# upgrade system and install packages
sudo apt update && sudo apt upgrade
sudo apt install -y \
    sway swaylock wayland-utils xwayland \
    grim slurp wl-clipboard kitty wofi \
    vlc thunar eog i3status curl \
    pipewire pipewire-audio-client-libraries \
    gvfs-backends gvfs-fuse mtp-tools jmtpfs thunar-volman \
    gnome-themes-extra \

systemctl --user start pipewire
systemctl --user enable pipewire

# install a web browser
curl -fsS https://dl.brave.com/install.sh | sudo bash