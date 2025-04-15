#!/bin/bash

set -e

# upgrade system and install packages
sudo apt update && sudo apt upgrade
sudo apt install -y \
    sway swaylock wayland-utils xwayland \
    grim slurp wl-clipboard kitty \
    vlc thunar i3status curl \
    xdg-desktop-portal xdg-desktop-portal-wlr \
    pipewire pipewire-audio-client-libraries

systemctl --user start pipewire
systemctl --user enable pipewire

# install a web browser
curl -fsS https://dl.brave.com/install.sh | sudo bash

# make config directories
mkdir -p ~/.config/sway
mkdir -p ~/.config/i3status

# copy sway and i3status configs
cp /etc/sway/config ~/.config/sway/
cp /etc/i3status.conf ~/.config/i3status/config

# set custom keyboard layout, kitty as default teminal, screen resolution, suspend option and bar placement
sed -i 's/^set \$term .*/set \$term kitty/' ~/.config/sway/config
sed -i '/^output /d' ~/.config/sway/config
echo -e "input * {\n    xkb_layout de\n}\n" >> ~/.config/sway/config
echo -e "output * {\n    mode 1920x1080@144Hz\n}\n" >> ~/.config/sway/config

# make keybindings for screenshotting and suspending system
echo 'bindsym $mod+Shift+s exec grim -g "$(slurp)" - | wl-copy' >> ~/.config/sway/config
echo 'bindsym $mod+Shift+z exec systemctl suspend && swaylock -c 000000' >> ~/.config/sway/config

# keybindings vor changing volume
echo 'bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+' >> ~/.config/sway/config
echo 'bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-' >> ~/.config/sway/config
echo 'bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle' >> ~/.config/sway/config

# customize bar
sed -i '/^bar {/,/^}/d' ~/.config/sway/config
cat <<EOF >> ~/.config/sway/config

bar {
    position bottom
    status_command i3status
}
EOF

# adjust i3status config
cat <<EOF > ~/.config/i3status/config
general {
    colors = true
    interval = 5
}

order += "wireless _first_"
order += "cpu_usage"
order += "volume master"
order += "tztime local"

wireless _first_ {
    format_up = "W: connected (%quality)"
    format_down = "W: not connected"
}

cpu_usage {
    format = "cpu usage: %usage"
}

volume master {
    format = "sound: %volume"
    format_muted = "sound: muted"
}

tztime local {
    format = "%H:%M:%S %d.%m.%Y"
}
EOF

# set sway autostart
echo '[[ "$(tty)" == "/dev/tty1" ]] && exec sway' >> ~/.bash_profile

# remove imagemagick
sudo apt purge imagemagick* -y
sudo apt autoremove --purge -y

# reboot system
sudo reboot -h now