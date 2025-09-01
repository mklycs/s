#!/bin/bash 

set -e

# remove annoying stuff
sudo apt purge zathura* foot* imagemagick* -y
sudo apt remove --purge gnome-keyring libpam-gnome-keyring seahorse xdg-desktop* -y
rm ~/.config/autostart/gnome-keyring*.desktop 2>/dev/null || true
sudo apt autoremove --purge -y
