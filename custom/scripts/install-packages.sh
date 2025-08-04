#!/bin/bash

set -e

# upgrade system and install packages
sudo apt update && sudo apt upgrade
sudo apt install -y \
    sway swaylock wayland-utils xwayland \
    grim slurp wl-clipboard kitty wofi \
    vlc thunar eog waybar curl unzip \
    pipewire pipewire-audio-client-libraries \
    gvfs-backends gvfs-fuse mtp-tools jmtpfs thunar-volman \
    gnome-themes-extra brightnessctl alsa-utils \
    build-essential pipx clang-15 clangd git \

systemctl --user start pipewire
systemctl --user enable pipewire

# install a brave browser
# curl -fsS https://dl.brave.com/install.sh | sudo bash

# install librewolf
sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y

# download the newest version of neovim
version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')

url="https://github.com/neovim/neovim/releases/download/${version}/nvim-linux-x86_64.appimage"
tmp_file="nvim.appimage"
target="/opt/neovim/nvim.appimage"

curl -Lo "$tmp_file" "$url"

sudo chmod +x "$tmp_file"
sudo mkdir -p /opt/neovim
sudo mv "$tmp_file" /opt/neovim/nvim.appimage
sudo ln -sf /opt/neovim/nvim.appimage /usr/local/bin/nvim

# download lazy
git clone https://github.com/folke/lazy.nvim ~/.local/share/nvim/lazy/lazy.nvim
