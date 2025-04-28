#!/bin/bash

set -e

# upgrade system and install packages
sudo apt update && sudo apt upgrade
sudo apt install -y \
    sway swaylock wayland-utils xwayland \
    grim slurp wl-clipboard kitty \
    vlc vim nnn feh i3status curl \
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

# keybindings for screenshotting and suspending system
echo 'bindsym $mod+Shift+s exec grim -g "$(slurp)" - | wl-copy' >> ~/.config/sway/config
echo 'bindsym $mod+Shift+z exec systemctl suspend && swaylock -c 000000' >> ~/.config/sway/config

# keybindings vor changing volume
echo 'bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+' >> ~/.config/sway/config
echo 'bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-' >> ~/.config/sway/config
echo 'bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle' >> ~/.config/sway/config

# move bar to bottom
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

# remove annoying stuff
sudo apt purge imagemagick* -y
sudo apt remove --purge gnome-keyring libpam-gnome-keyring seahorse -y
rm ~/.config/autostart/gnome-keyring*.desktop
sudo apt autoremove --purge -y

# adjust bash terminal colors
cat << 'EOF' >> ~/.bashrc

# >>> custom prompt with colored user@host <<<
color_prompt=yes

if [ "\$color_prompt" = yes ]; then
    PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[38;2;30;129;176m\]\u@\h\[\033[0m\]:\w\$ '
else
    PS1='\${debian_chroot:+(\$debian_chroot)}\u@\h:\w\$ '
fi

case "\$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\${debian_chroot:+(\$debian_chroot)}\u@\h: \w\a\]\$PS1"
    ;;
*)
    ;;
esac
# <<< end custom prompt >>>
EOF

# open files from nnn with vim or feh image viewer
cat << 'EOF' >> ~/.config/nnn-opener.sh
#!/bin/sh
case "$1" in
  *.jpg|*.jpeg|*.png|*.gif|*.webp)
    feh "$@" ;;
  *.c|*.cpp|*.py|*.sh|*.rs|*.html|*.css|*.js|*.ts|*.java|*.lua|*.txt|*.md)
    kitty -e vim "$@" ;;
  *)
    xdg-open "$@" ;;
esac
EOF

# make nnn-opener.sh executable
chmod +x ~/.config/nnn-opener.sh

# adjust .bashrc to export nnn-opener.sh
cat << 'EOF' >> ~/.bashrc

export NNN_USE_OPEN=1
export NNN_OPENER="$HOME/.config/nnn-opener.sh"
EOF

# reload .bashrc
source ~/.bashrc 

# set sway autostart
echo '[[ "$(tty)" == "/dev/tty1" ]] && exec sway' >> ~/.bash_profile

# reboot system
sudo reboot -h now